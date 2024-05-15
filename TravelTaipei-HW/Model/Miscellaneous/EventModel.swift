//
//  EventModel.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/10.
//

import Foundation

struct MiscellaneousResponseModel<T: Codable>: Codable {
    let total: Int
    let data: T // 將 data 的型別改為泛型 T
}

struct EventModel : Codable {
    let event : [IdNameModel]?

    enum CodingKeys: String, CodingKey {

        case event = "Event"
    }

}

struct ActivityModel : Codable {
    let activity : [IdNameModel]?
    
    enum CodingKeys: String, CodingKey {

        case activity = "Activity"
    }
}

struct FeaturePostsModel : Codable {
    let featurePosts : [IdNameModel]?
    
    enum CodingKeys: String, CodingKey {

        case featurePosts = "FeaturePosts"
    }
}

struct AccessibilityModel : Codable {
    let accessibility : [IdNameModel]?
    
    enum CodingKeys: String, CodingKey {

        case accessibility = "Accessibility"
    }
}

struct MiscellaneousCategoryModel : Codable {
    let category : [IdNameModel]?

    enum CodingKeys: String, CodingKey {

        case category = "Category"
    }
}

struct IdNameModel : Codable {
    let id : Int?
    let name : String?
}
