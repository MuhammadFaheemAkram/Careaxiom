//
//  APIClient.swift
//  Careaxiom
//
//  Created by BrainX IOS 3 on 13/09/2021.
//

import Foundation
import Alamofire
import ObjectMapper

protocol HTTPRequest {
	
	var endPoint: URL? { get }
	
	var method: HTTPMethod { get }
	
	var parameters: Parameters? { get }
	
	var headers: HTTPHeaders? { get }
	
}

extension HTTPRequest {
	
	var parameters: Parameters? { nil }
	
	var headers: HTTPHeaders? { nil }
}

typealias APIClientResult = Result<Any, CareaxiomError>

class APIClient {
	
	
	// MARK: - Class Instances
	
	static let shared = APIClient()
	
	
	// MARK: - Initializers
	
	private init() {}
	
	// MARK: - Public Methods
	
	func performRequest(_ request: HTTPRequest, shouldAddHeader : Bool = true, andCompletion completion: @escaping (APIClientResult) -> Void) {
		
		guard let url = request.endPoint else {
			completion(.failure(CareaxiomError(message: LocalizedKey.urlNotFound.string)))
			return
		}
		var headers: HTTPHeaders?
		
		let parameterEncoding: ParameterEncoding = request.method == .get ? URLEncoding() : JSONEncoding()

		AF.request(
			url, method: request.method,
			parameters: request.parameters,
			encoding: parameterEncoding,
			headers: headers
		).responseJSON { response in

			print(response)
			
			if response.response?.statusCode == 401 {
				//NotificationCenter.default.post(name: .sessionExpired, object: nil)
				return
			}
			
			let headers = response.response?.allHeaderFields ?? [:]
			switch response.result {
			case .success(let value):
				completion(.success((headers: headers, body: value)))
			case .failure(let error):
				guard let afError = error as? AFError else {
					completion(.failure(CareaxiomError(message: error.errorDescription ??
														LocalizedKey.somethingWentWrong.string)))
					return
				}
				switch afError {
				case .sessionTaskFailed( _):
					completion(.failure(CareaxiomError(message: LocalizedKey.noInternet.string)))
				default:
					completion(.failure(CareaxiomError(message: afError.errorDescription ??
														LocalizedKey.somethingWentWrong.string)))
				}
			
			}
		}
	}
}

