//
//  NewsFeedTableViewCell.swift
//  Careaxiom
//
//  Created by BrainX IOS 3 on 13/09/2021.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {

	// MARK: - Outlets

	@IBOutlet var lblTitle: UILabel!
	@IBOutlet var lblThumbnail: UILabel!

	// MARK: - Instance variables
	
	// MARK: - Helper Methods
	func setData(story: StoryModel) {
		lblTitle.text = story.title
		lblThumbnail.text = story.thumbnailUrl
	}

}
