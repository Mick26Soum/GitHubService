//
//  WebViewController.swift
//  GitbHubClient
//
//  Created by MICK SOUMPHONPHAKDY on 9/1/15.
//  Copyright (c) 2015 Mick Soum. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
	
	let webView = WKWebView()
	var url : String!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.webView.frame = self.view.frame
				self.view.addSubview(self.webView)
			

				let url = NSURL(string: self.url)
				let request = NSURLRequest(URL: url!)
				self.webView.loadRequest(request)
			
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
