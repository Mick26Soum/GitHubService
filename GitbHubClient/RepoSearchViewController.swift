//
//  RepoSearchViewController.swift
//  GitbHubClient
//
//  Created by Mick Soumphonphakdy on 8/17/15.
//  Copyright (c) 2015 Mick Soum. All rights reserved.
//

import UIKit

class RepoSearchViewController: UIViewController {
    
// MARK: IBOutlet
	
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!

	var repos = [Repository]()
	let imageQueue = NSOperationQueue()

	override func viewDidLoad() {
		  super.viewDidLoad()
		
			searchBar.delegate = self
			tableView.delegate = self
			tableView.dataSource = self
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showWeb"{
			let destinationVC = segue.destinationViewController as! WebViewController
			let selectedIndexPath = self.tableView.indexPathForSelectedRow()
			let repo = self.repos[selectedIndexPath!.row]
			destinationVC.url = repo.htmlURL
		}
	}
}

// MARK: SearchBar Delegate Extension
extension RepoSearchViewController : UISearchBarDelegate{
	
	func searchBarSearchButtonClicked(searchBar: UISearchBar) {
		searchBar.resignFirstResponder()  //hide the keyboard when done
		
		GitbHubService.repositoriesForSearchTerm(searchBar.text, repoSearchCallBack : { (errorDescription, repositories) -> (Void) in
			if errorDescription != nil{
				println("No Repoing")
			}else if let repositories = repositories{
				self.repos = repositories
				self.tableView .reloadData()
			}
		})
	}
	
	func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
		return text.validateForURL()
	}
}

// MARK: TableView Delegate Extension
extension RepoSearchViewController : UITableViewDelegate, UITableViewDataSource{
		
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.repos.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("repoCell", forIndexPath: indexPath) as! RepoTableViewCell
		cell.tag++
		let tag = cell.tag
		
		var repo = repos[indexPath.row]
		
		cell.repoURLLabel.text = repo.name
		
		if let image = repo.image{
			cell.repoImageView.image = image
		}else{
			ImageDownloader.getImageFile(repo.avatarUrl, imageQueue : imageQueue, completionHandler: { (image) -> () in
				repo.image = image
				self.repos[indexPath.row] = repo
				if cell.tag == tag{
					cell.repoImageView.image = repo.image
					}
				})
		}
		return cell
	}
}






