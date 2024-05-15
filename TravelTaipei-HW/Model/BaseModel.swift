//
//  BaseModel.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/11.
//

import Foundation

struct BaseModel<T: Codable>: Codable {
    let total: Int
    let data: [T] // 將 data 的型別改為泛型 T
    
    enum CodingKeys: String, CodingKey {

        case total = "total"
        case data = "data"
    }
}
