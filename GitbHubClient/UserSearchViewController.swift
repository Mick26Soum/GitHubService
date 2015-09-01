//
//  UserSearchViewController.swift
//  GitbHubClient
//
//  Created by MICK SOUMPHONPHAKDY on 9/1/15.
//  Copyright (c) 2015 Mick Soum. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController {

	// MARK: - IBOutlet
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var userCollectionView: UICollectionView!
	
	let imageQueue = NSOperationQueue()
	var users = [User]()
	
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
				userCollectionView.dataSource = self
			
    }
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showUserDetail"{
			if let destinationVC = segue.destinationViewController as? UserDetailViewController,
				indexPath = userCollectionView.indexPathsForSelectedItems().first as? NSIndexPath{
					let user = users[indexPath.row]
					destinationVC.selectedUser = user
			}
		}
	}
	
}

// MARK:Extensions

extension UserSearchViewController : UISearchBarDelegate{
	
	func searchBarSearchButtonClicked(searchBar : UISearchBar){
		searchBar.resignFirstResponder()
		
		GitbHubService.userForSearchTerm(searchBar.text, userSearchCallback: { (errorDescription, users) -> (Void) in
			if let error = errorDescription{
				println("Error in User")
			}else if let users = users{
				self.users = users
				self.userCollectionView.reloadData()
			}
		})
	}
	
	func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
		return text.validateForURL()
	}
	
}

extension UserSearchViewController : UICollectionViewDataSource{
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.users.count
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("userCell", forIndexPath: indexPath) as! UserCollectionViewCell
		
		cell.userImageView.image = nil
//		cell.hidden = false
//		cell.alpha = 0
		
		
		//userImageView
		cell.tag++
		let tag = cell.tag
		
		var user = users[indexPath.row]
		
		cell.userNameLabel.text = user.login
		
		
		if let image = user.image{
			cell.userImageView.image = image
		}else {
			ImageDownloader.getImageFile(user.avatarURL, imageQueue: imageQueue, completionHandler: { (image) -> () in
				user.image = image
				self.users[indexPath.row] = user
				if cell.tag == tag{
					cell.userImageView.image = user.image
				}
			})
		}
		
		
		return cell
	}
	
}

