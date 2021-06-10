//
//  Date+Extension.swift
//  Journal
//
//  Created by Cyril Garcia on 6/9/21.
//

import Foundation

extension Date {
    
    enum DateFormat: String {
        case halfDate = "E, MMM d"
        case fullDate = "EEEE, MMMM d, yyyy h:mm a"
        case time = "h:mma"
        case hour = "ha"
        case mHour = "H"
        case mtime = "H:mm"
        case day = "EEEE"
        case shortDay = "EE"
        case year = "yyyy"
        case truncFullDate = "MMM d, h a"
    }
    
    func toString(_ format: DateFormat = .fullDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale = Locale.autoupdatingCurrent
        
        return dateFormatter.string(from: Date(timeIntervalSince1970: self.timeIntervalSince1970))
    }
}
