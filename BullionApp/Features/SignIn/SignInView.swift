//
//  SignInView.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 20/12/25.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject private var router: AppRouter
    @StateObject private var viewModel = SignInViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Image(AppImages.bullionLogo)
                    .frame(maxHeight: .infinity)
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 16) {
                        CustomTextfieldView(label: "Email Address", text: $viewModel.email,type: .normal)
                            .labelWeight(.medium)

                        CustomTextfieldView(label: "Password", text: $viewModel.password,type: .secure)
                            .labelWeight(.medium)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        CustomButton(title: "Sign In") {
                            Task {
                                let success = await viewModel.signIn()
                                if success {
                                    router.push(.home)

                                }
                            }
                        }
                        CustomButton(title: "Add new Users") {}
                        
                    }
                }
                .padding(.vertical, 32)
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 390, alignment: .top)
                .background(AppColors.greyBackground)
                .cornerRadius(24)
            }
            
            if viewModel.isLoading {
                Color(.black)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .opacity(0.4)
                
                ProgressView("Signing In...")
                    .frame(width: 200, height: 240)
                    .background(.white)
                    .cornerRadius(16)
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(
            LinearGradient(
                stops: [
                    .init(color: AppColors.background1, location: 0),
                    .init(color: AppColors.background2, location: 0.37),
                    .init(color: AppColors.background3, location: 0.86)
                ],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        )
        .ignoresSafeArea()
        .alert("Sign In Failed", isPresented: $viewModel.isShowError) {
            Button("Try Again", role: .cancel) {
                viewModel.isShowError = false
            }
            .background(Color(AppColors.greyBackground))
        } message: {
            Text("Email or Password is incorrect")
        }
    }
}

#Preview {
       AppRouterView()
    
}
