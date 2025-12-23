//
//  MultipartFormData.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 23/12/25.
//

import Foundation

struct MultipartFormData {
    let name: String
    let filename: String?
    let mimeType: String?
    let data: Data
}
