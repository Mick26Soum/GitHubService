//
//  UserDetailViewController.swift
//  GitbHubClient
//
//  Created by MICK SOUMPHONPHAKDY on 9/1/15.
//  Copyright (c) 2015 Mick Soum. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

	@IBOutlet weak var userDetailImageView: UIImageView!
	
	var selectedUser:User!
	
    override func viewDidLoad() {
        super.viewDidLoad()
				userDetailImageView.image = selectedUser.image
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
