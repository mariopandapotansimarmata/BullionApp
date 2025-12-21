//
//  CustomButton.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 20/12/25.
//

import SwiftUI

struct CustomButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom(AppFonts.InterMedium, size: 14))
                .foregroundStyle(AppColors.white)
                .padding(.vertical)
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity)
                .background(AppColors.buttonBlue)
                .cornerRadius(.infinity)
        }
    }
}

#Preview {
    SignInView()
}
