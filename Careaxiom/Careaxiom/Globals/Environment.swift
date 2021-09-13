//
//  Environment.swift
//  Careaxiom
//
//  Created by BrainX IOS 3 on 13/09/2021.
//

import Foundation

enum Environment {
	
	case development
	case staging
	case production
	
	static var current: Environment { return .development }

	static var baseUrl: URL? {
		switch current {
		
		case .development: return URL(string: "https://jsonplaceholder.typicode.com/")
		case .staging: return URL(string: "")
		case .production: return URL(string: "")
		}
	}
	
}
