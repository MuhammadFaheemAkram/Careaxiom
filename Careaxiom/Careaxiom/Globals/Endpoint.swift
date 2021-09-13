//
//  Foundation.swift
//  Careaxiom
//
//  Created by BrainX IOS 3 on 13/09/2021.
//

import Foundation

enum Endpoint {
	
	static var storiesDara: URL? {
		URL(string: "photos", relativeTo: Environment.baseUrl)
	}
}
