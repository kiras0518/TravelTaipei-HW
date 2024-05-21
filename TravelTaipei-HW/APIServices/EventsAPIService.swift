//
//  EventsAPIService.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/11.
//

import Foundation
import UIKit

// 定義 EventsRequestParameters 參數封裝，可保持擴充性
// 参数封装 struct，以接收這個 struct 作為參數
struct EventsRequestParameters {
    var begin: String?
    var end: String?
    var page: Int?
    var categoryId: Int?
}

protocol EventsAPIServiceProtocol {
    
    func fetchNewsData(parameters: EventsRequestParameters,
                               completion: @escaping (Result<BaseModel<NewsModel>, APIError>) -> Void)
    func fetchActivityData(parameters: EventsRequestParameters,
                               completion: @escaping (Result<BaseModel<EventActivityModel>, APIError>) -> Void)
    func fetchCalendarData(parameters: EventsRequestParameters,
                               completion: @escaping (Result<BaseModel<EventCalendarModel>, APIError>) -> Void)
}

class EventsAPIService: EventsAPIServiceProtocol {

    private let apiServices: NetworkServices
    
    init(apiServices: NetworkServices) {
        self.apiServices = apiServices
    }

    func fetchNewsData(parameters: EventsRequestParameters, completion: @escaping (Result<BaseModel<NewsModel>, APIError>) -> Void) {
        apiServices.requestGenerator(route: EventsAPIConfiguration.news(begin: parameters.begin,
                                                                        end: parameters.end,
                                                                        page: parameters.page),
                                     type: BaseModel<NewsModel>.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                completion(.failure(.jsonConversionFailure))
            }
        }
    }
    
    func fetchActivityData(parameters: EventsRequestParameters, completion: @escaping (Result<BaseModel<EventActivityModel>, APIError>) -> Void) {
        apiServices.requestGenerator(route: EventsAPIConfiguration.activity(begin: parameters.begin,
                                                                            end: parameters.end,
                                                                            page: parameters.page),
                                     type: BaseModel<EventActivityModel>.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                completion(.failure(.jsonConversionFailure))
            }
        }
    }
    
    func fetchCalendarData(parameters: EventsRequestParameters, completion: @escaping (Result<BaseModel<EventCalendarModel>, APIError>) -> Void) {
        apiServices.requestGenerator(route: EventsAPIConfiguration.calendar(categoryId: parameters.categoryId,
                                                                            begin: parameters.begin,
                                                                            end: parameters.end,
                                                                            page: parameters.page),
                                     type: BaseModel<EventCalendarModel>.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                completion(.failure(.jsonConversionFailure))
            }
        }
    }

}
