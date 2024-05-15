//
//  ToursAPIService.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/10.
//

import Foundation

protocol ToursAPIServiceProtocol {
    func fetchData(categoryIds: String?, page: Int,
                   completion: @escaping (Result<BaseModel<ToursModel>, APIError>) -> Void)
}

class ToursAPIService: ToursAPIServiceProtocol {
    
    private let apiServices: NetworkServices
    
    init(apiServices: NetworkServices) {
        self.apiServices = apiServices
    }
    
    func fetchData(categoryIds: String?, page: Int, completion: @escaping (Result<BaseModel<ToursModel>, APIError>) -> Void) {
        apiServices.requestGenerator(route: ToursAPIConfiguration.theme(categoryIds: categoryIds, page: page),
                                     type: BaseModel<ToursModel>.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.serverError(message: error.localizedDescription)))
            }
        }
    }
}
