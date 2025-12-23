//
//  AddUserViewModel.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 20/12/25.
//

import Combine
import Foundation
import PhotosUI
import CryptoKit
import _PhotosUI_SwiftUI

class AddUserViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var gender: String = ""
    @Published var dateOfBirth: Date = Date()
    @Published var emailAddress: String = ""
    @Published var phoneNumber: String = ""
    @Published var photoProfile: UIImage?
    @Published var password: String = ""
    @Published var address: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var isNameValid: Bool = true
    @Published var isGenderValid: Bool = true
    @Published var isDateBirthValid: Bool = true
    @Published var isEmailValid: Bool = true
    @Published var isPhoneValid: Bool = true
    @Published var isPhotoValid: Bool = true
    @Published var isPasswordValid: Bool = true
    @Published var isConfirmPassValid: Bool = true
    
    @Published var isLoading: Bool = false
    
    @Published var dateOfBirthText: String = ""
    
    var dateOfBirthText1: String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.string(from: dateOfBirth)
    }
    
    func register() async -> Bool {
        isLoading = true
        defer { isLoading = false }
        do {
            let request = try makeRegisterRequest()
            let parts = request.toMultipart()
            print(request)

            let response: ApiResponse<RegisterResponse> = try await NetworkService.shared
                .uploadMultipart(
                    "/api/v1/auth/register",
                    parts: parts,
                    responseType: ApiResponse<RegisterResponse>.self
                )

            print("REGISTER SUCCESS:", response)
            return true
        } catch {
            print("REGISTER ERROR:", error.localizedDescription)
            return false
        }
    }
}

extension AddUserViewModel {

    var firstName: String {
        name.split(separator: " ").first.map(String.init) ?? ""
    }

    var lastName: String {
        let parts = name.split(separator: " ")
        return parts.count > 1
            ? parts.dropFirst().joined(separator: " ")
            : ""
    }
    
    
    func makeRegisterRequest() throws -> RegisterRequest {

        guard let image = photoProfile,
              let imageData = image.jpegData(compressionQuality: 0.8)
        else {
            throw NetworkError.custom("Photo profile wajib diisi")
        }

        return RegisterRequest(
            firstName: firstName,
            lastName: lastName,
            gender: gender,
            dateOfBirth: dateOfBirthText1,
            email: emailAddress,
            phone: phoneNumber,
            address: address,
            passwordHash: password /*sha256(password)*/ ,
            photoData: imageData
        )
    }
    func sha256(_ input: String) -> String {
        let data = Data(input.utf8)
        let hash = SHA256.hash(data: data)
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
