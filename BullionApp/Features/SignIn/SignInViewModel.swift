//
//  SignInViewModel.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 20/12/25.
//

import Combine

class SignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
}
