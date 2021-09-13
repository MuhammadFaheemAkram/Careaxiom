//
//  LocalizedKey.swift
//  Careaxiom
//
//  Created by BrainX IOS 3 on 13/09/2021.
//

import Foundation


enum LocalizedKey: String {
    var string: String {
        NSLocalizedString(rawValue, comment: "")
    }

    case ok = "OK"
    case appName = "Careaxiom"
	case urlNotFound = "Url not found"
	case somethingWentWrong = "Something went wrong"
	case noInternet = "No Internet Connection"
	case failedToParseData = "Failed To Parse Data"
	case error	= "Error"
}
