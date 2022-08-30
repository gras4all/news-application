//
//  DatesHelper.swift
//  mvpExample
//
//  Created by Андрей Груненков on 24.08.2022.
//

import Foundation

struct DatesHelper {
    
    static func parseDate(from date: String, pattern: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = pattern
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: date)
    }
    
    static func dateToString(from date: Date, pattern: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = pattern
        return dateFormatter.string(from: date)
    }
    
}
