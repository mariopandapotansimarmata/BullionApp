//
//  CustomSelectBoxView.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 21/12/25.
//

import SwiftUI

struct CustomSelectBoxView: View {
    
    @Binding var gender: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Gender")
                .font(.custom(AppFonts.InterRegular, size: 14))
                .foregroundStyle(
                    LinearGradient(
                        stops: [
                            .init(color: AppColors.foregroundText1, location: 0),
                            .init(color: AppColors.foregroundText2, location: 0.67),
                            .init(color: AppColors.foregroundText3, location: 1)],
                        startPoint: .bottomLeading, endPoint: .topTrailing))
            HStack(spacing: 10) {
                HStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(AppColors.white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(AppColors.darkGray, lineWidth: 1)
                        }
                        .overlay {
                            if gender == "male" {
                                Image(systemName: "checkmark")
                            }
                        }
                        .onTapGesture {
                            if gender != "male" {
                                gender = "male"
                            } else {
                                gender = ""
                            }
                        }
                    
                    Text("Male")
                        .font(.custom(AppFonts.RobotoRegular, size: 14))
                }
                
                HStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(AppColors.white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(AppColors.darkGray, lineWidth: 1)
                        }
                        .overlay {
                            if gender == "female" {
                                Image(systemName: "checkmark")
                            }
                        }
                        .onTapGesture {
                            if gender != "female" {
                                gender = "female"
                            } else {
                                gender = ""
                            }
                        }
                    
                    Text("Female")
                        .font(.custom(AppFonts.RobotoRegular, size: 14))
                }
            }
        }
    }
}
