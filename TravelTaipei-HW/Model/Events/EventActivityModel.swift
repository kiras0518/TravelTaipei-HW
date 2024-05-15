//
//  EventActivityModel.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/12.
//

import Foundation

struct EventActivityModel : Codable {
    let distric : String?
    let address : String?
    let nlat : String?
    let elong : String?
    let organizer : String?
    let co_rganizer : String?
    let contact : String?
    let tel : String?
    let fax : String?
    let ticket : String?
    let traffic : String?
    let parking : String?
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
        
        case distric = "distric"
        case address = "address"
        case nlat = "nlat"
        case elong = "elong"
        case organizer = "organizer"
        case co_rganizer = "co_rganizer"
        case contact = "contact"
        case tel = "tel"
        case fax = "fax"
        case ticket = "ticket"
        case traffic = "traffic"
        case parking = "parking"
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
