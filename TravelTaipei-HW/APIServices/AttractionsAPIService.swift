//
//  AttractionsAPIService.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/10.
//

import Foundation
import Alamofire

protocol AttractionsAPIServiceProtocol {
    func fetchAttractions(categoryIds: String?, nlat: Double?, elong: Double?, page: Int?,
                          completion: @escaping (Result<BaseModel<AttractionsModel>, APIError>) -> Void)
}

class AttractionsAPIService: AttractionsAPIServiceProtocol {
    
    private let apiServices: NetworkServices
    
    init(apiServices: NetworkServices) {
        self.apiServices = apiServices
    }
    
    func fetchAttractions(categoryIds: String?, nlat: Double?, elong: Double?, page: Int?,
                          completion: @escaping (Result<BaseModel<AttractionsModel>, APIError>) -> Void) {
        apiServices.requestGenerator(route: AttractionsAPIConfiguration.all(categoryIds: categoryIds, nlat: nlat, elong: elong, page: page),
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
