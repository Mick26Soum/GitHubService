//
//  RepoTableViewCell.swift
//  GitbHubClient
//
//  Created by MICK SOUMPHONPHAKDY on 8/31/15.
//  Copyright (c) 2015 Mick Soum. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

	@IBOutlet weak var repoImageView: UIImageView!
	@IBOutlet weak var repoURLLabel: UILabel!
	
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
