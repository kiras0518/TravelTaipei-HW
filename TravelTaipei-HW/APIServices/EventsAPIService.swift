//
//  EventsAPIService.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/11.
//

import Foundation
import UIKit

protocol EventsAPIServiceProtocol {
    func fetchNewsData<T: Codable>(begin: String?, end: String?, page: Int?,
                               modelType: T.Type,
                               completion: @escaping (Result<BaseModel<NewsModel>, APIError>) -> Void)
    func fetchActivityData<T: Codable>(begin: String?, end: String?, page: Int?,
                               modelType: T.Type,
                               completion: @escaping (Result<BaseModel<EventActivityModel>, APIError>) -> Void)
    func fetchCalendarData<T: Codable>(categoryId: Int?, begin: String?, end: String?, page: Int?,
                               modelType: T.Type,
                               completion: @escaping (Result<BaseModel<EventCalendarModel>, APIError>) -> Void)
    
}

class EventsAPIService: EventsAPIServiceProtocol {
 
    private let apiServices: NetworkServices
    
    init(apiServices: NetworkServices) {
        self.apiServices = apiServices
    }
    
    
    private func presentErrorAlert() {
        
    }
    
    func fetchNewsData<T>(begin: String?, end: String?, page: Int?, modelType: T.Type, completion: @escaping (Result<BaseModel<NewsModel>, APIError>) -> Void) where T : Decodable, T : Encodable {
        apiServices.requestGenerator(route: EventsAPIConfiguration.news(begin: begin, end: end, page: page), type: BaseModel<NewsModel>.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                completion(.failure(.jsonConversionFailure))
            }
        }
    }
    
    func fetchActivityData<T>(begin: String?, end: String?, page: Int?, modelType: T.Type, completion: @escaping (Result<BaseModel<EventActivityModel>, APIError>) -> Void) where T : Decodable, T : Encodable {
        apiServices.requestGenerator(route: EventsAPIConfiguration.activity(begin: begin, end: end, page: page), type: BaseModel<EventActivityModel>.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                completion(.failure(.jsonConversionFailure))
            }
        }
    }
    
    func fetchCalendarData<T>(categoryId: Int?, begin: String?, end: String?, page: Int?, modelType: T.Type, completion: @escaping (Result<BaseModel<EventCalendarModel>, APIError>) -> Void) where T : Decodable, T : Encodable {
        apiServices.requestGenerator(route: EventsAPIConfiguration.calendar(categoryId: categoryId, begin: begin, end: end, page: page) , type: BaseModel<EventCalendarModel>.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                completion(.failure(.jsonConversionFailure))
            }
        }
    }
    
}
