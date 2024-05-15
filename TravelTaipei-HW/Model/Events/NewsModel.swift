//
//  NewsModel.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/11.
//

import Foundation

struct NewsModel : Codable {
    let id : Int?
    let title : String?
    let description : String?
    let begin : String?
    let end : String?
    let posted : String?
    let modified : String?
    let url : String?
    let files : [FilesModel]?
    let links : [LinksModel]?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case description = "description"
        case begin = "begin"
        case end = "end"
        case posted = "posted"
        case modified = "modified"
        case url = "url"
        case files = "files"
        case links = "links"
    }
}
