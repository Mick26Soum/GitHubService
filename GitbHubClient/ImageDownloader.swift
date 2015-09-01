//
//  ImageDownloader.swift
//  GitbHubClient
//
//  Created by MICK SOUMPHONPHAKDY on 8/31/15.
//  Copyright (c) 2015 Mick Soum. All rights reserved.
//

import UIKit

class ImageDownloader {
	
	class func getImageFile(url : String, imageQueue : NSOperationQueue, completionHandler : (UIImage) ->()){
		imageQueue.addOperationWithBlock { () -> Void in
			if let url = NSURL(string: url){
				if let imageData = NSData(contentsOfURL: url){
					if let image = UIImage(data: imageData){
						NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
							completionHandler(image)
						})
					}
				}
			}
		}
	}
}