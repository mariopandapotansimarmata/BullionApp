//
//  DetailCardView.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 22/12/25.
//

import SwiftUI

struct DetailCardView: View {
    var body: some View {
        VStack(alignment: .leading ,spacing: 10) {
            HStack {
                Spacer()
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 8, height: 8)
            }
            
            Image(AppImages.profilePlaceholder)
                .resizable()
                .frame(width: 64, height: 64)
            
            VStack(alignment: .leading) {
                Text("Ghalyatama Ikram Fauzi")
                    .font(.custom(AppFonts.InterMedium, size: 12))
                Text(verbatim: "ghalyatama@bullion.com")
                    .font(.custom(AppFonts.InterMedium, size: 10))
                    .foregroundStyle(AppColors.darkGray2)
            }
            
            VStack(alignment: .leading) {
                Text(verbatim: "Gender")
                    .font(.custom(AppFonts.InterMedium, size: 10))
                    .foregroundStyle(AppColors.darkGray2)
                Text("MALE")
                    .font(.custom(AppFonts.InterMedium, size: 12))
            }
            VStack(alignment: .leading) {
                Text(verbatim: "Phone Number")
                    .font(.custom(AppFonts.InterMedium, size: 10))
                    .foregroundStyle(AppColors.darkGray2)
                Text("082182822828")
                    .font(.custom(AppFonts.InterMedium, size: 12))
            }
             VStack(alignment: .leading) {
                Text(verbatim: "Date of Birth")
                    .font(.custom(AppFonts.InterMedium, size: 10))
                    .foregroundStyle(AppColors.darkGray2)
                Text("14 May 1998")
                    .font(.custom(AppFonts.InterMedium, size: 12))
            }
             VStack(alignment: .leading) {
                Text(verbatim: "Address")
                    .font(.custom(AppFonts.InterMedium, size: 10))
                    .foregroundStyle(AppColors.darkGray2)
                Text("JL Moh Hatta Gg Bunga Emas No.1002 Tanjung Senang, Bandar Lampung")
                    .font(.custom(AppFonts.InterMedium, size: 12))
            }
            
            CustomButton(title: "Edit User") {
                
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(AppColors.white)
        .cornerRadius(16)
        .padding(28)
    }
}
