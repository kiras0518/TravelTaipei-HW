//
//  Extension++.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/10.
//

import Foundation

extension DateFormatter {
    static var articleDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}

extension Date {
    func toString(withFormat format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        return dateFormatter.string(from: self)
    }
}
