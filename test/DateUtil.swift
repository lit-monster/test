//
//  DateUtil.swift
//  test
//
//  Created by Masakaz Ozaki on 2022/06/10.
//

import Foundation

class DateUtils {
    class func stringFromDate(date: Date, format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
