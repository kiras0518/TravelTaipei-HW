//
//  ToursAPIService.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/10.
//

import Foundation

struct ToursRequestParameters {
    var categoryIds: String?
    var page: Int?
}

protocol ToursAPIServiceProtocol {
    func fetchData(parameters: ToursRequestParameters,
                   completion: @escaping (Result<BaseModel<ToursModel>, APIError>) -> Void)
}

class ToursAPIService: ToursAPIServiceProtocol {
    
    private let apiServices: NetworkServices
    
    init(apiServices: NetworkServices) {
        self.apiServices = apiServices
    }
    
    func fetchData(parameters: ToursRequestParameters,
                   completion: @escaping (Result<BaseModel<ToursModel>, APIError>) -> Void) {
        
        let toursAPIConfiguration = ToursAPIConfiguration.theme(categoryIds: parameters.categoryIds,
                                                                page: parameters.page)
        
        apiServices.requestGenerator(route: toursAPIConfiguration,
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
