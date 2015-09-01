//
//  ImageResizer.swift
//  GitbHubClient
//
//  Created by MICK SOUMPHONPHAKDY on 8/31/15.
//  Copyright (c) 2015 Mick Soum. All rights reserved.
//  Source: Josh Nagel

import UIKit


class ImageResizer {
    
    class func resizeImage(image: UIImage, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
	
}
