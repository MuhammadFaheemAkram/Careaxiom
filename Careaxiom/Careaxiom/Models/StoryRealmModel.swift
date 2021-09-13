//
//  StoryRealmModel.swift
//  Careaxiom
//
//  Created by BrainX IOS 3 on 13/09/2021.
//

import Foundation
import RealmSwift

class StoryRealmModel: Object {
	
	@Persisted var albumId: Int?
	@Persisted var id: Int?
	@Persisted var title: String?
	@Persisted var url: String?
	@Persisted var thumbnailUrl: String?
	
	convenience init(model: StoryModel) {
		self.init()
		albumId = model.albumId
		id = model.id
		title = model.title
		url = model.url
		thumbnailUrl = model.thumbnailUrl
	}
}
