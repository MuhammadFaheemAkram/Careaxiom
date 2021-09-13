//
//  StoriesRepository.swift
//  Careaxiom
//
//  Created by BrainX IOS 3 on 13/09/2021.
//

import Foundation
import Alamofire
import ObjectMapper

typealias TaskResult = Result<[StoryModel],CareaxiomError>
typealias CompletionResult = Result<[StoryModel],CareaxiomError>

class StoriesRepository {
    
    func getStories(withCompletion completion: @escaping (TaskResult) -> Void ){
    
        APIClient.shared.performRequest(TaskRequest.tasks, shouldAddHeader: false, andCompletion: {
            result in
            switch result {
            case .success(let value):
                guard  let (_,body) = value as? (Any, Any) else {
                    completion(.failure(CareaxiomError(message: LocalizedKey.failedToParseData.string)))
                    return
                }
                
                if let error = Mapper<CareaxiomError>().map(JSONObject: body) {
                    completion(.failure(error))
                    return
                }
                
                guard  let tasks = Mapper<StoryModel>().mapArray(JSONObject: body) else {
                    completion(.failure(CareaxiomError(message: LocalizedKey.failedToParseData.string)))
                    return
                }
                
                completion(.success(tasks))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
}

enum TaskRequest: HTTPRequest {
    case tasks
}

extension TaskRequest {
    
    var method: HTTPMethod {
        switch self {
		case .tasks:
			return .get
        }
    }
    
    var endPoint: URL? {
        switch self {
			case .tasks: return Endpoint.storiesDara
        }
    }
    
	var parameters: Parameters? {
		switch self {
		case .tasks:
			return nil
		}
	}
}

