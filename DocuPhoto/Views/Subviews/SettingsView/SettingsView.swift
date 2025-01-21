//
//  SettingsView.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 12.12.2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: MainViewModel
    @EnvironmentObject var subscriptionManager: ApphudSubsManager
    @State var isSubsPresented: Bool = false
    @State private var isShareSheetPresented = false
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.gray)
                .frame(width: 120, height: 5)
                .edgesIgnoringSafeArea(.horizontal)
                .padding(.top, 20)
            
            Text("Settings")
                .font(.system(size: 18))
                .bold()
                .padding(.bottom, 30)
                .padding(.top, 25)
            
            if !subscriptionManager.hasSubscription{
                HStack (spacing: 10) {
                    Image("diamonds")
                        .resizable()
                        .frame(width: 35, height: 35)
                    
                    
                    Text("Get Premium!")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(.black)
                    
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(25)
                .background(
                    ZStack (alignment: .trailing) {
                        LinearGradient(
                            gradient: Gradient(colors: [.newGradientStart, .newGradientEnd]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .padding(.trailing, 70)
                        .scaleEffect(2)
                        
                        Image("stars")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 84, height: 84)
                            .opacity(0.2)
                    }
                )
                .cornerRadius(16)
                .padding(.horizontal)
                .padding(.bottom, 40)
                .onTapGesture {
                    isSubsPresented = true
                }
                .sheet(isPresented: $isSubsPresented) {
                    PaywallView(paywallId: ApphudPaywallIds.settings.rawValue)
                        .presentationDetents([.height(768)])
                        .presentationCornerRadius(30)
                        .environmentObject(subscriptionManager)
                }
                .onChange(of: subscriptionManager.hasSubscription, { oldValue, newValue in
                    isSubsPresented = false
                })
            }
            
            Button(action: {
                viewModel.showingInstructions = true
            }, label: {
                SettingsRow(icon: "question", title: "How do you create your perfect passport photo?")
            })
            
            SettingsRow(icon: "message", title: "Write a feedback")
                            .onTapGesture {
                                openAppStoreForReview()
                            }
                        
                        SettingsRow(icon: "export", title: "Share this app")
                            .onTapGesture {
                                isShareSheetPresented.toggle()
                            }
                            .sheet(isPresented: $isShareSheetPresented) {
                                ShareSheet(activityItems: ["https://apps.apple.com/app/id6739844446"], excludedActivityTypes: [])
                                    .presentationDetents([.medium, .large])
                            }
            
            Spacer()
        }
    }
    func openAppStoreForReview() {
        let appStoreReviewURL = "https://apps.apple.com/app/id6739844446?action=write-review"
        if let url = URL(string: appStoreReviewURL) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(MainViewModel())
}
