//
//  Date+Extension.swift
//  Flickr
//
//  Created by Nagarjuna on 26/10/2018.
//  Copyright © 2018 Universe. All rights reserved.
//

import Foundation
import UIKit

public extension Date {

    public enum DateFormatType: String {
        case isoDate = "yyyy-MM-dd"
        case isoDateTime = "yyyy-MM-dd'T'HH:mmZ"
        case isoDateTimeSec = "yyyy-MM-dd'T'HH:mm:ssZ"
        public var dateFormatter: DateFormatter {
            switch self {
            case .isoDate: return Date.DateFormatters.isoDateFormatter
            case .isoDateTime: return Date.DateFormatters.isoDateTimeFormatter
            case .isoDateTimeSec: return Date.DateFormatters.isoDateTimeSecFormatter
            }
        }
    }

    private struct DateFormatters {
        public static let isoDateFormatter = createDateFormatter(formatType: .isoDate)
        public static let isoDateTimeFormatter = createDateFormatter(formatType: .isoDateTime)
        public static let isoDateTimeSecFormatter = createDateFormatter(formatType: .isoDateTimeSec)
    }

    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        return formatter
    }()

    private static func createDateFormatter(formatType: DateFormatType) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.dateFormat = formatType.rawValue
        return dateFormatter
    }

    public static func date(from string: String, format: String) -> Date? {
        Date.dateFormatter.dateFormat = format
        return Date.dateFormatter.date(from: string)
    }

    public static func date(from string: String, formatType: DateFormatType) -> Date? {
        return self.date(from: string, format: formatType.rawValue)
    }
}

