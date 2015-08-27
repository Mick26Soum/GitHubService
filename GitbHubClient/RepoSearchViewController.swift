//
//  RepoSearchViewController.swift
//  GitbHubClient
//
//  Created by Mick Soumphonphakdy on 8/17/15.
//  Copyright (c) 2015 Mick Soum. All rights reserved.
//

import UIKit

class RepoSearchViewController: UIViewController {
	
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!
	
	var repos = [Repository]()
	let imageQueue = NSOperationQueue()

	override func viewDidLoad() {
		  super.viewDidLoad()
			searchBar.delegate = self
	
	}
	
}


// MARK: SearchBar Delegate Extension
extension RepoSearchViewController : UISearchBarDelegate{
	
	func searchBarSearchButtonClicked(searchBar: UISearchBar) {
		searchBar.resignFirstResponder()  //What does this do?
		
		GitbHubService.repositoriesForSearchTerm(searchBar.text, repoSearchCallBack : { (errorDescription, repositories) -> (Void) in
			if errorDescription != nil{
				println("No Repoing")
			}else if let repositories = repositories{
				self.repos = repositories
				self.tableView .reloadData()
			}
		})
	}
}

// MARK: TableView Delegate Extension
extension RepoSearchViewController : UITableViewDelegate, UITableViewDataSource{
		
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.repos.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("repoCell", forIndexPath: indexPath) as! UITableViewCell
		
		//set the properties of the cell
		
		
		return cell
	}
}

