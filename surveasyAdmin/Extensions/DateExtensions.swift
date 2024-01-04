//
//  DateExtensions.swift
//  surveasyAdmin
//
//  Created by Jin Hyeok Choi on 2023/06/02.
//

import Foundation

extension Date {
    func DateToDateString(dateToFormat: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let convertDate = dateFormatter.string(from: dateToFormat)
        return convertDate
    }
    
    func DateToTimeString(dateToFormat: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let convertDate = dateFormatter.string(from: dateToFormat)
        return convertDate
    }
}
