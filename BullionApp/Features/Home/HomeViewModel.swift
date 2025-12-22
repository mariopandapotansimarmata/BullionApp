//
//  HomeViewModel.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 21/12/25.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var listData:[UserProfile] = []
    @Published var isShowError = false
    @Published var errorMessage = ""
    @Published var isLoading = true
    @Published var isShowDetailAccount = false
    @Published var selectedBanner: Int? = 0
    @Published var selectedUser: UserProfile?

    func fetchUsers() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response : ApiResponse<[UserProfile]> = try await NetworkService.shared.get(
                "/api/v1/admin",
                query: ["offset":"5","limit":"5"],
                responseType: ApiResponse<[UserProfile]>.self
            )
            print(response.data)
            listData = response.data
        } catch {
            errorMessage = error.localizedDescription
            isShowError = true
            print(error)
        }
    }
}
