//
//  LanguageManager.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/15.
//

import Foundation

enum LanguageCode: String {
    case zhTW = "zh-tw"
    case zhCN = "zh-cn"
    case en = "en"
    case ja = "ja"
    case ko = "ko"
    case es = "es"
    case id = "id"
    case th = "th"
    case vi = "vi"
}

class LanguageManager {
    
    static let shared = LanguageManager()
    
    private init() {}
    
    var currentLanguage: LanguageCode = .zhTW
    
    func setCurrentLanguage(_ languageCode: LanguageCode) {
        currentLanguage = languageCode
    }
    
    //本地化語言
    func localizedString(forKey key: String) -> String {
        let bundle = Bundle.main
        return bundle.localizedString(forKey: key, value: nil, table: "Localizable")
    }
}

extension LanguageManager {
    
    func getBarTitleForCurrentLanguage() -> String {
        switch currentLanguage {
        case .zhTW:
            return "悠遊台北"
        case .zhCN:
            return "悠游台北"
        case .en:
            return "Travel Taipei"
        case .ja:
            return "トラベル台北"
        case .ko:
            return "타이베이 여행"
        case .es:
            return "Viajar a Taipei"
        case .id:
            return "Travel Taipei"
        case .th:
            return "เที่ยวไทเป"
        case .vi:
            return "Du lịch Đài Bắc"
        }
    }
    
    func getNewsTitleForCurrentLanguage() -> String {
        switch currentLanguage {
        case .zhTW:
            return "最新消息"
        case .zhCN:
            return "最新动态" 
        case .en:
            return "Latest News"
        case .ja:
            return "最新ニュース"
        case .ko:
            return "최신 소식"
        case .es:
            return "Últimas noticias"
        case .id:
            return "Berita Terbaru"
        case .th:
            return "ข่าวล่าสุด"
        case .vi:
            return "Tin tức mới nhất"
        }
    }
    
    func getSpotsTitleForCurrentLanguage() -> String {
        switch currentLanguage {
        case .zhTW:
            return "遊憩景點"
        case .zhCN:
            return "观光景点"
        case .en:
            return "Sightseeing Spots"
        case .ja:
            return "観光スポット"
        case .ko:
            return "관광 명소"
        case .es:
            return "Lugares de interés"
        case .id:
            return "Tempat Wisata"
        case .th:
            return "สถานที่ท่องเที่ยว"
        case .vi:
            return "Điểm tham quan"
        }
    }
}
