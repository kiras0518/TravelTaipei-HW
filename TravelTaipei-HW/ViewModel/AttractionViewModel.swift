//
//  AttractionViewModel.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/15.
//

import Foundation

class AttractionViewModel {
    
    private let sttractionService: AttractionsAPIServiceProtocol

    var attractionsData: DynamicValue<[AttractionsModel]> = DynamicValue([])
    
    var errorMessage: DynamicValue<String?> = DynamicValue(nil)
    
    init(sttractionService: AttractionsAPIServiceProtocol = AttractionsAPIService(apiServices: NetworkServices())) {
        self.sttractionService = sttractionService
    }
    
    func getAttraction(categoryIds: String?, nlat: Double?, elong: Double?, page: Int?) {
        
        sttractionService.fetchAttractions(parameters:
                                            AttractionRequestParameters(categoryIds: categoryIds,
                                                                        nlat: nlat,
                                                                        elong: elong,
                                                                        page: page)) { [weak self] result in
            switch result {
            case .success(let baseModel):
                self?.attractionsData.value = baseModel.data
            case .failure(let error):
                print("Error fetching news: \(error.localizedDescription)")
                self?.errorMessage.value = "Error fetching news: \(error.localizedDescription)"
            }
        }
    }
}
