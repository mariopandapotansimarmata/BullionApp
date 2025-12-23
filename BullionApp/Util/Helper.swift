//
//  Helper.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 22/12/25.
//

import Foundation

class Helper {
    static func loadFromInfoPlist(_ key: String) -> String {
        guard let apiBaseUrl = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
            fatalError()
        }
        return apiBaseUrl
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex)
            .evaluate(with: email)
    }
}
