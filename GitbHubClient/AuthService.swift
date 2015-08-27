//
//  AuthService.swift
//  GitbHubClient
//
//  Created by Mick Soumphonphakdy on 8/18/15.
//  Copyright (c) 2015 Mick Soum. All rights reserved.
//

import UIKit

class AuthService{

	class func performInitialRequest(){
	
		// Call openURL on a singleton instance of your app to open Github api url to request temp code
		UIApplication.sharedApplication().openURL(NSURL(string: "https://github.com/login/oauth/authorize?client_id=\(kClientID)&redirect_uri=MicksApiService://oAuth&scope=user,repo")!)
	}
	
	class func gitURLCodeExchange(codeURL : NSURL){
		
		// Triggered in handleOpenURL method of AppDelegate with second request appended with tempCode for access token request
		if let tempCode = codeURL.query{
			 let request = NSMutableURLRequest(URL: NSURL(string: "https://github.com/login/oauth/access_token?\(tempCode)&client_id=\(kClientID)&client_secret=\(kClientSecrect)")!)
			 request.HTTPMethod = "POST"
			 request.setValue("application/json", forHTTPHeaderField: "Accept")
			
			 NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
				if let httpURLResponse = response as? NSHTTPURLResponse{
					
					var jsonError:NSError?
					
					if let rootJSON = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [String : AnyObject],
					accessToken = rootJSON["access_token"] as? String{
				
					KeychainService.saveToken(accessToken)
						
					//call post the NSNotification for the setNewTokenID
					NSNotificationCenter.defaultCenter().postNotificationName(knewTokenSetID, object: nil)
						
					}
				}
			}).resume()
		}
		
	}
	
}
