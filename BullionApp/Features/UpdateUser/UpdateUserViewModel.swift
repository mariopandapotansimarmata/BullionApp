//
//  UpdateUserViewModel.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 22/12/25.
//

import Combine
import Foundation
import PhotosUI

class UpdateUserViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var gender: String = ""
    @Published var dateOfBirth: Date = Date()
    @Published var emailAddress: String = ""
    @Published var phoneNumber: String = ""
    @Published var dateOfBirthText: String = ""
    @Published var address: String = ""
    @Published var photoProfile: UIImage?
    
    @Published var isNameValid: Bool = true
    @Published var isGenderValid: Bool = true
    @Published var isDateBirthValid: Bool = true
    @Published var isEmailValid: Bool = true
    @Published var isPhoneValid: Bool = true
    @Published var isPhotoValid: Bool = true

    func base64ToUIImage(_ base64String: String) -> UIImage? {
        var cleaned = base64String


        if let commaIndex = cleaned.firstIndex(of: ",") {
            cleaned = String(cleaned[cleaned.index(after: commaIndex)...])
        }

        guard let data = Data(base64Encoded: cleaned) else {
            print("Failed decode Base64")
            return nil
        }

        return UIImage(data: data)
    }
}
