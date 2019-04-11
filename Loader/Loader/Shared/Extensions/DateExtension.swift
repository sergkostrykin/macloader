//
//  DateExtension.swift
//  Loader
//
//  Created by Sergiy Kostrykin on 4/11/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import Foundation

extension Date {
    
    
    /// Returns Date Formatter for date in format yyyy-MM-dd'T'HH:mm:ss.SSSZ
    static let standardDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: Calendar.Identifier.iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = .utc
        return dateFormatter
    }()
    
    /// Returns human-readable date in format yyyy-MM-dd'T'HH:mm:ss.SSSZ
    var backendString: String {
        return Date.standardDateFormatter.string(from: self)
    }
    
}

extension TimeZone {
    
    /// Returns UTC time zone
    static let utc: TimeZone = {
        return TimeZone(identifier: "UTC")!
    }()
    
}
