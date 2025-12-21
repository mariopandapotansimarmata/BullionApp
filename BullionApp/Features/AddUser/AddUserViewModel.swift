//
//  AddUserViewModel.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 20/12/25.
//

import Combine
import Foundation

class AddUserViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var gender: String = ""
    @Published var dateOfBirth: Date = Date()
    @Published var emailAddress: String = ""
    @Published var phoneNumber: String = ""
    @Published var photoProfile: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var dateOfBirthText: String = ""

}
