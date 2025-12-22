//
//  ApiResponse.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 22/12/25.
//


struct ApiResponse<T: Codable>: Codable {
    let status: Int
    let isError: Bool
    let message: String
    let data: T

    enum CodingKeys: String, CodingKey {
        case status
        case isError = "iserror"
        case message
        case data
    }
}
