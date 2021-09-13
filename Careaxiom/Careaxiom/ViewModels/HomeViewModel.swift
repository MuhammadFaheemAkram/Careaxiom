//
//  HomeViewModel.swift
//  Careaxiom
//
//  Created by BrainX IOS 3 on 13/09/2021.
//

import Foundation

class HomeViewModel {
	
	// MARK: - Instance Properties

	private var router: HomeRouter?
	var storyGroup = Dictionary<Int, [StoryModel]>()
	var storyKeys = [Int]()
	private var storiesList = [StoryModel]()
	private let storiesRepository = StoriesRepository()

	// MARK: - Init Methods

	required init(router: HomeRouter) {
		self.router = router
	}
	
	init(storiesList: [StoryModel]) {
		self.storiesList = storiesList
		self.converIntoGroup()
	}

	// MARK: - Public Methods
	
	func fetchStories(withCompletion completion: @escaping () -> Void ) {
		
		router?.viewController?.showLoader(true)
		storiesRepository.getStories(withCompletion: {
			result in
			self.router?.viewController?.showLoader(false)
			switch result {
			case .success(let stories):
				self.storiesList = stories
				self.saveStoriesToLocal()
				self.converIntoGroup()
				completion()
			case .failure(let error):
				let message = error.message ?? LocalizedKey.somethingWentWrong.string
				self.router?.viewController?.showAlertView(message: message, title: LocalizedKey.error.string)
				completion()
			}
		})
	}
	
	// MARK: - Private Methods
	private func converIntoGroup() {
		storyGroup = Dictionary(grouping: storiesList, by: {$0.albumId ?? 0})
		storyKeys = storyGroup.keys.sorted()
	}
	
	private func saveStoriesToLocal() {
		RealmManager.sharedInstance.addStories(modelList: storiesList)
	}
	
}

