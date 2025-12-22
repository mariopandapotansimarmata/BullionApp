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
}
