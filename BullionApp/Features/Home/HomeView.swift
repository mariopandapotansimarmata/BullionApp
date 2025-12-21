//
//  HomeView.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 21/12/25.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var numOfBanner: Int = 3
    @State var selectedBanner: Int? = 0
    let bannerWidth: CGFloat = 360
    let bannerHeight: CGFloat = 180
    @State var isShowDetailAccount = false
    
    var body: some View {
        ZStack {
            VStack {
                ScrollViewReader { proxy in
                    ScrollView(.horizontal) {
                        HStack(spacing: 12) {
                            ForEach(0..<numOfBanner, id: \.self) { index in
                                Image(AppImages.banner)
                                    .resizable()
                                    .frame(width: bannerWidth, height: bannerHeight)
                                    .cornerRadius(12)
                                    .id(index)
                            }
                        }
                        .scrollTargetLayout()
                        .padding(.horizontal,12)
                    }
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.viewAligned)
                    .scrollPosition(id: $selectedBanner)
                    .frame(maxWidth: .infinity)
                    
                    HStack {
                        ForEach(0..<numOfBanner,  id: \.self) {num in
                            Circle()
                                .foregroundStyle(
                                    AppColors.bannerIndicator
                                        .opacity(
                                            selectedBanner == num ? 1 : 0.5
                                        )
                                )
                                .frame(width: 8, height: 8)
                                .onTapGesture {
                                    withAnimation {
                                        proxy.scrollTo(num, anchor: .center)
                                        selectedBanner = num
                                    }
                                }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                
                
                VStack(alignment: .leading) {
                    Text("List Users")
                        .font(.custom(AppFonts.InterRegular, size: 14))
                        .foregroundStyle(
                            LinearGradient(
                                stops: [
                                    .init(color: AppColors.foregroundText1, location: 0),
                                    .init(color: AppColors.foregroundText2, location: 0.67),
                                    .init(color: AppColors.foregroundText3, location: 1)],
                                startPoint: .bottomLeading, endPoint: .topTrailing)
                        )
                    
                    VStack {
                        ScrollView {
                            ForEach(0..<10, id: \.self) { _ in
                                UserCardView()
                                    .onTapGesture {
                                        isShowDetailAccount.toggle()
                                    }
                            }
                            .padding(.bottom)
                        }
                        .scrollIndicators(.hidden)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        CustomButton(title: "Add new Users") {}
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
            .frame(maxHeight: .infinity, alignment: .top)
            
            if isShowDetailAccount {
                Color(.black)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .opacity(0.4)
                    .onTapGesture {
                        isShowDetailAccount.toggle()
                    }
                DetailCardView()
            }
        }
        .toolbar {
            if #available(iOS 26.0, *) {
                ToolbarItem(placement: .topBarLeading) {
                    Image(AppImages.bullionLogo)
                        .frame(width: 104, height: 32)
                        .padding(.leading, 24)
                }
                .sharedBackgroundVisibility(.hidden)
            } else {
                ToolbarItem(placement: .topBarLeading) {
                    Image(AppImages.bullionLogo)
                        .frame(width: 104, height: 32)
                        .padding(.leading, 24)
                }
            }
            
            if #available(iOS 26.0, *) {
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        dismiss()
                    } label: {
                        Text("Logout")
                            .font(.custom(AppFonts.InterSemiBold, size: 12))
                            .foregroundStyle(.white)
                    }
                }
                .sharedBackgroundVisibility(.hidden)
            } else {
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        dismiss()
                    } label: {
                        Text("Logout")
                            .font(.custom(AppFonts.InterSemiBold, size: 12))
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
    NavigationStack {
        HomeView()
    }
}
