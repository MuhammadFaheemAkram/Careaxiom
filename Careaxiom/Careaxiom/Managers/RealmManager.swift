//
//  RealmManager.swift
//  Careaxiom
//
//  Created by BrainX IOS 3 on 13/09/2021.
//

import Foundation
import RealmSwift

class RealmManager {
	
	
	// MARK: - Class Instances
	private var realm: Realm? {
		do {
			return try Realm()
		} catch {
			return nil
		}
	}
	
	static let sharedInstance = RealmManager()
	
	// MARK: - Private Init
	private init() {}
	
	public func addStory(model : StoryModel){
		let story = StoryRealmModel(model: model)
		do {
			try realm?.write{
				realm?.add(story)
			}
		} catch {
			print(error.localizedDescription)
		}
	}
	
	public func addStories(modelList : [StoryModel]){
		var storyList = [StoryRealmModel]()
		for model in modelList {
			storyList.append(StoryRealmModel(model: model))
		}
		do {
			try realm?.write{
				realm?.add(storyList)
			}
		} catch {
			print(error.localizedDescription)
		}
	}
	
	public func getAllStories() -> [StoryRealmModel]{
		let meetingsList = realm?.objects(StoryRealmModel.self)
		return meetingsList?.toArray(ofType: StoryRealmModel.self) ?? []
	}
	
	
}
