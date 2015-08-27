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

	override func viewDidLoad() {
		  super.viewDidLoad()
			searchBar.delegate = self
	}
	
}


//MARK: - SearchBar Delegate Extesnio

extension RepoSearchViewController : UISearchBarDelegate{

	func searchBarSearchButtonClicked(searchBar: UISearchBar) {
		GitbHubService.repositoriesForSearchTerm(searchBar.text)
	}
	
}
