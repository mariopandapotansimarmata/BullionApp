//
//  AddUserView.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 20/12/25.
//

import SwiftUI
import PhotosUI

struct AddUserView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel = AddUserViewModel()
    @State private var isShowDatePicker: Bool = false
    @State private var selectedItem: PhotosPickerItem?
    @State private var isShowPassword: Bool = false
    @State private var isShowConfirmPassword: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            CustomTextfieldView(label: "Name", text: $viewModel.name,type: .normal, isValidForm: $viewModel.isNameValid)
                            
                            CustomSelectBoxView(gender: $viewModel.gender)
                            
                            CustomTextfieldView(
                                label: "Date of Birth",
                                text: $viewModel.dateOfBirthText,
                                isValidForm: $viewModel.isDateBirthValid,
                                type: .normal,
                                isDisableField: true,
                                
                            ) {
                                Image(AppImages.calendar)
                                    .onTapGesture {
                                        isShowDatePicker.toggle()
                                    }
                            }
                            
                            CustomTextfieldView(label: "Email Address", text: $viewModel.emailAddress,type: .normal,                                 isValidForm: $viewModel.isEmailValid,
                            )
                            
                            CustomTextfieldView(label: "Phone Number", text: $viewModel.phoneNumber,type: .normal,                                 isValidForm: $viewModel.isPhoneValid,
                            )
                            
                              CustomTextfieldView(label: "Adress", text: $viewModel.address,type: .normal,                                 isValidForm: $viewModel.isPhoneValid,
                            )
                            
                            CustomTextfieldView(
                                label: "Photo Picture",
                                text: .constant("Photo"),
                                isValidForm: $viewModel.isPhotoValid,
                                type: .normal,
                                isDisableField: true
                            ) {
                                PhotosPicker(
                                    selection: $selectedItem,
                                    matching: .images
                                ) {
                                    Image(AppImages.link)
                                }
                            }
                            .onChange(of: selectedItem) { oldItem, newItem in
                                guard let newItem else { return }
                                
                                Task {
                                    if let data = try? await newItem.loadTransferable(type: Data.self),
                                       let image = UIImage(data: data) {
                                        
                                        viewModel.photoProfile = image
                                        
                                        viewModel.isPhotoValid = true
                                    } else {
                                        viewModel.isPhotoValid = false
                                    }
                                }
                            }
                            
                            CustomTextfieldView(
                                label: "Password",
                                description: "Min 8 Char | Min 1 Capital and Number",
                                text: $viewModel.password,
                                isValidForm: $viewModel.isPasswordValid,
                                type: isShowPassword ? .normal : .secure) {
                                    Image(systemName: isShowPassword ? "eye" : "eye.slash" )
                                        .foregroundStyle(AppColors.buttonBlue)
                                        .onTapGesture {
                                            isShowPassword.toggle()
                                        }
                                }
                            
                            CustomTextfieldView(
                                label: "Confirm Password",
                                description: "Make sure the password matches",
                                text: $viewModel.confirmPassword,
                                isValidForm: $viewModel.isConfirmPassValid,
                                type: isShowConfirmPassword ? .normal : .secure) {
                                    Image(systemName: isShowConfirmPassword ? "eye" : "eye.slash" )
                                        .foregroundStyle(AppColors.buttonBlue)
                                        .onTapGesture {
                                            isShowConfirmPassword.toggle()
                                        }
                                }
                        }
                    }
                    .scrollIndicators(.hidden)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        CustomButton(title: "Add new Users") {
                            Task {
                                let isSuccess = await viewModel.register()
                                if isSuccess {
                                    dismiss()
                                }
                                
                            }
                        }
                    }
                }
                .padding(.vertical, 32)
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(maxHeight: .infinity, alignment: .top)
                .background(AppColors.greyBackground)
                .cornerRadius(24)
            }
            .padding(.top)
            
            if viewModel.isLoading {
                Color(.black)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .opacity(0.4)
                
                VStack {
                    ProgressView("Loading..")
                        .frame(width: 200, height: 240)
                        .background(.white)
                        .cornerRadius(16)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
            }
            
            
            if isShowDatePicker {
                Color(.black)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .opacity(0.4)
                    .onTapGesture {
                        isShowDatePicker = false
                    }
                
                VStack {
                    DatePicker("Date of Birth", selection: $viewModel.dateOfBirth, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .background(.white)
                        .cornerRadius(16)
                        .onChange(of: viewModel.dateOfBirth) { _, newDate in
                            viewModel.dateOfBirthText = newDate.toString()
                        }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.dateOfBirthText = viewModel.dateOfBirth.toString()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image(AppImages.bullionLogo)
            }
            
            if #available(iOS 26.0, *) {
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.white)
                    }
                }
                .sharedBackgroundVisibility(.hidden)
            } else {
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.white)
                    }
                }
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
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack{
        AddUserView()
    }
}
