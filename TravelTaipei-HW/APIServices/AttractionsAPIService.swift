//
//  AttractionsAPIService.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/10.
//

import Foundation
import Alamofire

struct AttractionRequestParameters {
    var categoryIds: String?
    var nlat: Double?
    var elong: Double?
    var page: Int?
}

protocol AttractionsAPIServiceProtocol {
    func fetchAttractions(parameters: AttractionRequestParameters,
                          completion: @escaping (Result<BaseModel<AttractionsModel>, APIError>) -> Void)
}

class AttractionsAPIService: AttractionsAPIServiceProtocol {
    
    private let apiServices: NetworkServices
    
    init(apiServices: NetworkServices) {
        self.apiServices = apiServices
    }
    
    func fetchAttractions(parameters: AttractionRequestParameters,
                          completion: @escaping (Result<BaseModel<AttractionsModel>, APIError>) -> Void) {
        
        let attractionsAPIConfiguration = AttractionsAPIConfiguration.all(categoryIds: parameters.categoryIds,
                                                    nlat: parameters.nlat,
                                                    elong: parameters.elong,
                                                    page: parameters.page)
        
        apiServices.requestGenerator(route: attractionsAPIConfiguration,
                                     type: BaseModel<AttractionsModel>.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                completion(.failure(.jsonConversionFailure))
            }
        }
    }
}
