//
//  ApiErrorResponse.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 22/12/25.
//

struct ApiErrorResponse: Codable {
    let errorCode: String
    let message: String
    let messageEN: String

    enum CodingKeys: String, CodingKey {
        case errorCode = "err_code"
        case message = "err_message"
        case messageEN = "err_message_en"
    }
}
