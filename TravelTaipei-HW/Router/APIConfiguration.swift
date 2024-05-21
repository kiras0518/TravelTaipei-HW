//
//  APIServicesRouter.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/9.
//

import Alamofire
import Foundation

protocol APIConfiguration: URLRequestConvertible {
    var baseURL: String { get }
    var languagePath: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
}

extension APIConfiguration {
    
    var baseURL: String {
        return "https://www.travel.taipei/open-api/"
    }
    
    var languagePath: String {
        return LanguageManager.shared.currentLanguage.rawValue
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default // 預設使用 URLEncoding，可以根據需要進行更改
    }
    
    var headers: HTTPHeaders {
        return ["accept": "application/json"]
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseURL + languagePath + path)
        var request = URLRequest(url: url!)
        
        request.method = method
        request.headers = headers
        print("asURLRequest parameters: ", parameters)
        return try encoding.encode(request, with: parameters)
    }
    
    func buildParameters(_ parameters: [String: Any]) -> Parameters {
           var params: Parameters = self.parameters ?? [:]
           parameters.forEach { params[$0] = $1 }
           return params
       }
}

enum AttractionsAPIConfiguration: APIConfiguration {
    
    case all(categoryIds: String?, nlat: Double?, elong: Double?, page: Int?)
    
    var method: HTTPMethod { .get }
    
    var parameters: Parameters? {
        switch self {
        case .all(let categoryIds, let nlat, let elong, let page):
            var params: [String: Any] = [:]
            if let categoryIds = categoryIds {
                params["categoryIds"] = categoryIds
            }
            if let nlat = nlat {
                params["nlat"] = nlat
            }
            if let elong = elong {
                params["elong"] = elong
            }
            if let page = page {
                params["page"] = page
            }
            return params
        }
        
    }
    
    var path: String { "/Attractions/All" }
}

enum EventsAPIConfiguration: APIConfiguration {
    
    case news(begin: String?, end: String?, page: Int?)
    case activity(begin: String?, end: String?, page: Int?)
    case calendar(categoryId: Int?, begin: String?, end: String?, page: Int?)

    var method: HTTPMethod { .get }
    
    var parameters: Parameters? {
        switch self {
        case .news(let begin, let end, let page),
                .activity(let begin, let end, let page):
            
            var params: [String: Any] = [:]
            if let begin = begin {
                params["begin"] = begin
            }
            if let end = end {
                params["end"] = end
            }
            if let page = page {
                params["page"] = page
            }
            return params

        case .calendar(let categoryId, let begin, let end, let page):
            
            var params: [String: Any] = [:]
            
            if let categoryId = categoryId {
                params["categoryId"] = categoryId
            }
            if let begin = begin {
                params["begin"] = begin
            }
            if let end = end {
                params["end"] = end
            }
            if let page = page {
                params["page"] = page
            }
            return params
        }
    }
    
    var path: String {
        switch self {
        case .news:
            return "/Events/News"
        case .activity:
            return "/Events/Activity"
        case .calendar:
            return "/Events/Calendar"
        }
    }
}

enum MediaAPIConfiguration {
    
}

enum MiscellaneousAPIConfiguration: APIConfiguration {
   
    case categories(type: String)

    var method: HTTPMethod { .get }
    
    var parameters: Parameters? {
        switch self {
        case .categories(let type):
            return ["type": type]
        }
        
    }
    
    var path: String { "/Miscellaneous/Categories" }
    
}

enum ToursAPIConfiguration: APIConfiguration {
    
    case theme(categoryIds: String?, page: Int?)

    var method: HTTPMethod { .get }
    
    var parameters: Parameters? {
        switch self {
        case .theme(let categoryIds, let page):
            return ["categoryIds": categoryIds ?? "",
                    "page": page ?? 0]
        }
        
    }
    
    var path: String { "/Tours/Theme" }
}
