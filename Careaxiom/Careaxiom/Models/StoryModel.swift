//
//  StoryModel.swift
//  Careaxiom
//
//  Created by BrainX IOS 3 on 13/09/2021.
//

import Foundation
import ObjectMapper

struct StoryModel: Mappable {
	
	init?(map: Map) {}
	
	var albumId: Int?
	var id: Int?
	var title: String?
	var url: String?
	var thumbnailUrl: String?
	
	mutating func mapping(map: Map) {
		albumId <- map["albumId"]
		id <- map["id"]
		title <- map["title"]
		url <- map["url"]
		thumbnailUrl <- map["thumbnailUrl"]
	}
}
