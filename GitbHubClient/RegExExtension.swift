//
//  RegExExtension.swift
//  GitbHubClient
//
//  Created by MICK SOUMPHONPHAKDY on 9/1/15.
//  Copyright (c) 2015 Mick Soum. All rights reserved.
//

import Foundation

extension String {
	func validateForURL() -> Bool {
		
		var error : NSError?
		
		if let regex = NSRegularExpression(pattern: "[^0-9a-zA-Z\n]", options: nil, error: &error){
			let matches = regex.numberOfMatchesInString(self, options: nil, range:NSRange(location: 0, length: count(self)))
			
			return matches > 0 ?  false : true
		}
		return false
		
	}
}