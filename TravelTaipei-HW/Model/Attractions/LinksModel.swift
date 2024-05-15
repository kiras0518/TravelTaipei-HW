//
//  LinksModel.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/9.
//

import Foundation

struct LinksModel : Codable {
    let src : String?
    let subject : String?
}

struct FilesModel: Codable {
    let src: URL
    let subject: String
    let ext: String
}
