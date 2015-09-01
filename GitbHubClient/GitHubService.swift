//
//  GitHubService.swift
//  GitbHubClient
//
//  Created by Mick Soumphonphakdy on 8/17/15.
//  Copyright (c) 2015 Mick Soum. All rights reserved.
//

import UIKit

class GitbHubService{
	
	class func repositoriesForSearchTerm(searchTerm : String, repoSearchCallBack : (errorDescription : String?, repo : [Repository]?) -> (Void) ){
		
		let baseURL = "https://api.github.com/search/repositories"
	  let finalURL = baseURL + "?q=\(searchTerm)"
		let request = NSMutableURLRequest(URL: NSURL(string: finalURL)!)
		if let token = KeychainService.loadToken() {
			request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
		}
		
	  if let url = NSURL(string: finalURL){
				NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
					if let error = error{
						println("error")
						repoSearchCallBack(errorDescription: "No Data Is Available", repo: nil)
					} else if let httpResponse = response as? NSHTTPURLResponse{
						
						switch httpResponse.statusCode{
						case 200...299:
							println("We have data")
							if let repos = JSONParser.repoJSONParser(data){
								NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
									repoSearchCallBack(errorDescription: nil, repo: repos)
								})
							}
						default:
							println("default")
						}
						
					}
				}).resume()
		  }
	}
	
	class func userForSearchTerm(searchTerm : String, userSearchCallback : (errorDescription : String?, users :[User]?) -> (Void)) {
		let baseURL = "https://api.github.com/search/users"
		let finalURL = baseURL + "?q=\(searchTerm)"
		let request = NSMutableURLRequest(URL: NSURL(string: finalURL)!)
		if let token = KeychainService.loadToken() {
			request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
		}
		
		if let url = NSURL(string: finalURL) {
			NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
				if let error = error {
					println("error")
				} else if let httpResponse = response as? NSHTTPURLResponse {
					println(httpResponse)
					if httpResponse.statusCode == 200 {
						if let users = JSONParser.userJSONParser(data) {
							NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
								userSearchCallback(errorDescription: nil, users: users)
							})
						}
					}
					userSearchCallback(errorDescription: nil, users: nil)
				}
			}).resume()
		}
	}
	
}
