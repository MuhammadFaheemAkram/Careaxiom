//
//  CareaxiomTests.swift
//  CareaxiomTests
//
//  Created by BrainX IOS 3 on 13/09/2021.
//

import XCTest
import ObjectMapper
@testable import Careaxiom

class CareaxiomTests: XCTestCase {
	
	var homeViewModel: HomeViewModel?

    override func setUpWithError() throws {
		let storiesList = Mapper<StoryModel>().mapArray(JSONString: storyListingStub)
		homeViewModel = HomeViewModel(storiesList: storiesList!)
    }

	func testStoriesListNotEmpty() {
		XCTAssertEqual(homeViewModel?.storyGroup.count, 1)
	}

	func testGroupIdIsOne() {
		XCTAssertEqual(homeViewModel?.storyKeys.first, 1)
	}
	
	func testStoriesInFirstGroupIs27() {
		XCTAssertEqual(homeViewModel?.storyGroup[homeViewModel?.storyKeys.first ?? 1]?.count, 27)
	}

}
