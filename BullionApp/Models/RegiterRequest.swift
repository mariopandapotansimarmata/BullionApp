//
//  RegiterRequest.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 23/12/25.
//

import Foundation

struct RegisterRequest {
    let firstName: String
    let lastName: String
    let gender: String
    let dateOfBirth: String
    let email: String
    let phone: String
    let address: String
    let passwordHash: String
    let photoData: Data
}

extension RegisterRequest {
    func toMultipart() -> [MultipartFormData] {
        [
            .init(
                name: "first_name",
                filename: nil,
                mimeType: nil,
                data: Data(firstName.utf8)
            ),
            .init(
                name: "last_name",
                filename: nil,
                mimeType: nil,
                data: Data(lastName.utf8)
            ),
            .init(
                name: "gender",
                filename: nil,
                mimeType: nil,
                data: Data(gender.utf8)
            ),
            .init(
                name: "date_of_birth",
                filename: nil,
                mimeType: nil,
                data: Data("1995-08-31T00:00:00.000Z".utf8)
            ),
            .init(
                name: "email",
                filename: nil,
                mimeType: nil,
                data: Data(email.utf8)
            ),
            .init(
                name: "phone",
                filename: nil,
                mimeType: nil,
                data: Data(phone.utf8)
            ),
            .init(
                name: "address",
                filename: nil,
                mimeType: nil,
                data: Data(address.utf8)
            ),
            .init(
                name: "password",
                filename: nil,
                mimeType: nil,
                data: Data(passwordHash.utf8)
            ),
            .init(
                name: "photo",
                filename: "avatar.jpg",
                mimeType: "image/jpeg",
                data: photoData
            )
        ]
    }
}
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
