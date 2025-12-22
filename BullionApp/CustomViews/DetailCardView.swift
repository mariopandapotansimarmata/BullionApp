//
//  DetailCardView.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 22/12/25.
//

import SwiftUI

struct DetailCardView: View {
    
    @EnvironmentObject private var router: AppRouter
    @Binding var isShowDetailAccount: Bool
    @Binding var user: UserProfile?
    
    var body: some View {
        VStack(alignment: .leading ,spacing: 10) {
            HStack {
                Spacer()
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 8, height: 8)
                    .onTapGesture {
                        isShowDetailAccount.toggle()
                    }
            }
            
            Image(AppImages.profilePlaceholder)
                .resizable()
                .frame(width: 64, height: 64)
            
            VStack(alignment: .leading) {
                Text(user?.name ?? "")
                    .font(.custom(AppFonts.InterMedium, size: 12))
                Text(verbatim: user?.email ?? "")
                    .font(.custom(AppFonts.InterMedium, size: 10))
                    .foregroundStyle(AppColors.darkGray2)
            }
            
            VStack(alignment: .leading) {
                Text(verbatim: "Gender")
                    .font(.custom(AppFonts.InterMedium, size: 10))
                    .foregroundStyle(AppColors.darkGray2)
                Text(user?.gender.rawValue.capitalized ?? "-")
                    .font(.custom(AppFonts.InterMedium, size: 12))
            }
            VStack(alignment: .leading) {
                Text(verbatim: "Phone Number")
                    .font(.custom(AppFonts.InterMedium, size: 10))
                    .foregroundStyle(AppColors.darkGray2)
                Text(user?.phone ?? "")
                    .font(.custom(AppFonts.InterMedium, size: 12))
            }
             VStack(alignment: .leading) {
                Text(verbatim: "Date of Birth")
                    .font(.custom(AppFonts.InterMedium, size: 10))
                    .foregroundStyle(AppColors.darkGray2)
                 Text(user?.dateOfBirth?.toString() ?? "-")
                    .font(.custom(AppFonts.InterMedium, size: 12))
            }
             VStack(alignment: .leading) {
                Text(verbatim: "Address")
                    .font(.custom(AppFonts.InterMedium, size: 10))
                    .foregroundStyle(AppColors.darkGray2)
                Text(user?.address ?? "")
                    .font(.custom(AppFonts.InterMedium, size: 12))
            }
            
            CustomButton(title: "Edit User") {
                router.push(.addUser)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(AppColors.white)
        .cornerRadius(16)
        .padding(28)
    }
}

