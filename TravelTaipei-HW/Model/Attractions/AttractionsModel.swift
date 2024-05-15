//
//  AttractionsModel.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/9.
//

import Foundation

struct AttractionsModel : Codable {
    let id : Int?
    let name : String?
    let name_zh : String?
    let open_status : Int?
    let introduction : String?
    let open_time : String?
    let zipcode : String?
    let distric : String?
    let address : String?
    let tel : String?
    let fax : String?
    let email : String?
    let months : String?
    let nlat : Double?
    let elong : Double?
    let official_site : String?
    let facebook : String?
    let ticket : String?
    let remind : String?
    let staytime : String?
    let modified : String?
    let url : String?
    let category : [CategoryModel]?
    let target : [TargetModel]?
    let service : [ServiceModel]?
    let friendly : [IdNameModel]?
    let images : [ImagesModel]?
    let files : [FilesModel]?
    let links : [LinksModel]?
}
