//
//  UserCardView.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 21/12/25.
//

import SwiftUI

struct UserCardView: View {
    var body: some View {
        HStack {
            HStack {
                Image(AppImages.profilePlaceholder)
                
                VStack(alignment: .leading) {
                    Text("Ghalyatama Ikram Fauzi")
                        .font(.custom(AppFonts.InterMedium, size: 12))
                    Text(verbatim: "ghalyatama@bullion.com")
                        .font(.custom(AppFonts.InterMedium, size: 10))
                        .foregroundStyle(AppColors.darkGray2)
                }
            }
            
            Spacer()
            
            Text("May 14,1998")
                .font(.custom(AppFonts.InterMedium, size: 10))
                .foregroundStyle(AppColors.darkGray2)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(8)
        .shadow(
            color: Color.black.opacity(0.1),
            radius: 4,
            x: 0,
            y: 2
        )
    }
}
