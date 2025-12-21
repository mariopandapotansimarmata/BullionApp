//
//  Date+Extension.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 21/12/25.
//

import Foundation

extension Date {
    func toString(format: String = "dd MMM yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "id_ID")
        return formatter.string(from: self)
    }
}
