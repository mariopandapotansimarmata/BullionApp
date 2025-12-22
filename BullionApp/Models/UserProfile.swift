//
//  UserProfile.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 22/12/25.
//

import Foundation

struct UserProfile: Codable, Identifiable {
    let id: String
    let name: String
    let gender: Gender
    let dateOfBirth: Date?
    let email: String
    let photo: String
    let phone: String
    let address: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case gender
        case dateOfBirth = "date_of_birth"
        case email
        case photo
        case phone
        case address
    }
}

enum Gender: String, Codable {
    case male
    case female
}
