//
//  MiscellaneousAPIService.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/10.
//

import Foundation

protocol MiscellaneousAPIServiceProtocol {
    // 使用泛型 T 來動態指定回傳的 EventBaseModel 泛型型別
    func fetchData<T: Codable>(categoryType: String, modelType: T.Type, completion: @escaping (Result<MiscellaneousResponseModel<T>, APIError>) -> Void)
}

class MiscellaneousAPIService: MiscellaneousAPIServiceProtocol {

    private let apiServices: NetworkServices
    
    init(apiServices: NetworkServices) {
        self.apiServices = apiServices
    }

    func fetchData<T>(categoryType: String,
                      modelType: T.Type,
                      completion: @escaping (Result<MiscellaneousResponseModel<T>, APIError>) -> Void) where T : Decodable, T : Encodable {
        
        apiServices.requestGenerator(route: MiscellaneousAPIConfiguration.categories(type: categoryType),
                                     type: MiscellaneousResponseModel<T>.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                completion(.failure(.jsonConversionFailure))
            }
        }
    }
    
    func fetchActivity(type: String, completion: @escaping (Result<MiscellaneousResponseModel<ActivityModel>, APIError>) -> Void) {
        fetchData(categoryType: type, modelType: ActivityModel.self, completion: completion)
    }
    
    func fetchCalendar(type: String, completion: @escaping (Result<MiscellaneousResponseModel<EventModel>, APIError>) -> Void) {
        fetchData(categoryType: type, modelType: EventModel.self, completion: completion)
    }
    
    func fetchPictorial(type: String, completion: @escaping (Result<MiscellaneousResponseModel<FeaturePostsModel>, APIError>) -> Void) {
        fetchData(categoryType: type, modelType: FeaturePostsModel.self, completion: completion)
    }

    func fetchCategories(type: String, completion: @escaping (Result<MiscellaneousResponseModel<MiscellaneousCategoryModel>, APIError>) -> Void) {
        fetchData(categoryType: type, modelType: MiscellaneousCategoryModel.self, completion: completion)
    }

    func fetchAttractions(type: String, completion: @escaping (Result<MiscellaneousResponseModel<ActivityModel>, APIError>) -> Void) {
        fetchData(categoryType: type, modelType: ActivityModel.self, completion: completion)
    }

    func fetchGourmet(type: String, completion: @escaping (Result<MiscellaneousResponseModel<AccessibilityModel>, APIError>) -> Void) {
        fetchData(categoryType: type, modelType: AccessibilityModel.self, completion: completion)
    }

    func fetchConsume(type: String, completion: @escaping (Result<MiscellaneousResponseModel<AccessibilityModel>, APIError>) -> Void) {
        fetchData(categoryType: type, modelType: AccessibilityModel.self, completion: completion)
    }

    func fetchAccommodation(type: String, completion: @escaping (Result<MiscellaneousResponseModel<AccessibilityModel>, APIError>) -> Void) {
        fetchData(categoryType: type, modelType: AccessibilityModel.self, completion: completion)
    }

    func fetchTours(type: String, completion: @escaping (Result<MiscellaneousResponseModel<MiscellaneousCategoryModel>, APIError>) -> Void) {
        fetchData(categoryType: type, modelType: MiscellaneousCategoryModel.self, completion: completion)
    }

}
