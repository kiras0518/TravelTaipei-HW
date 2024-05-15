//
//  ToursModel.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/10.
//

import Foundation

struct ToursModel : Codable {
    let id : Int?
    let seasons : [String]?
    let months : [String]?
    let days : Int?
    let title : String?
    let author : String?
    let description : String?
    let consume : String?
    let remark : String?
    let note : String?
    let url : String?
    let category : String?
    let transport : String?
    let users : String?
    let modified : String?
    let files : [String]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case seasons = "seasons"
        case months = "months"
        case days = "days"
        case title = "title"
        case author = "author"
        case description = "description"
        case consume = "consume"
        case remark = "remark"
        case note = "note"
        case url = "url"
        case category = "category"
        case transport = "transport"
        case users = "users"
        case modified = "modified"
        case files = "files"
    }
}
