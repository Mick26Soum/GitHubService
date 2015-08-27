//
//  LoginViewController.swift
//  GitbHubClient
//
//  Created by Mick Soumphonphakdy on 8/23/15.
//  Copyright (c) 2015 Mick Soum. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

// MARK:IBAction
	@IBAction func loginButtonPressed(sender: AnyObject) {
		// Should delete this button as users are redirected to GitHub for login
	}
	
	override func viewDidLoad() {
			super.viewDidLoad()
		// Post Notification is actived in AuthService when new token is set
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "newSetToken", name: knewTokenSetID, object: nil)
		
	}

	override func viewDidAppear(animated: Bool) {
			super.viewDidAppear(animated)
		if let gitToken = KeychainService.loadToken(){
			
		}else{
			AuthService.performInitialRequest()
		}
	}

	func newSetToken(){
		performSegueWithIdentifier("showMenu", sender: nil)
	}
	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
