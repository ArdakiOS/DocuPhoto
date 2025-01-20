//
//  OnboardingStep.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 09.12.2024.
//

import SwiftUI


struct OnboardingStep: View {
    @EnvironmentObject var subscriptionManager: ApphudSubsManager
    
    let imageName: String
    let title: String
    let description: String
    let description2: String
    let description3: String
    let buttonText: String
    
    var textPadding: CGFloat = 29
    let descriptionSpacing: CGFloat = 15
    var isRemoveBgShown: Bool = false 
    @Binding var currentStep: Int
    @State var isSubsPresented: Bool = false

    var body: some View {
        ZStack (alignment: .bottom) {
            Image(imageName)
                .resizable()
            
            VStack {
                VStack (spacing: 0) {
                    Text(title)
                        .font(.system(size: 28).weight(.semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.black)
                        .padding(.top, textPadding)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text(description)
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.black)
                        .padding(.top, descriptionSpacing)
                    
                    Text(description2)
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.black)
                        .padding(.top, descriptionSpacing)
                    
                    Text(description3)
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.black)
                        .padding(.top, descriptionSpacing)
                    
                    
                    CustomProgressBar(totalSteps: 4, currentStep: currentStep)
                        .padding(.vertical, 16)
                    
                

                    
                    Button(action: {
                        if currentStep == 3 {
                            isSubsPresented.toggle()
                        } else {
                            currentStep += 1
                        }
                    }) {
                        Text(buttonText)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.colorPrimary)
                            .foregroundColor(.accent)
                            .cornerRadius(25)
                        
                    }
                    .padding(.bottom, 49)
                    .padding(.horizontal, 48)
                    .sheet(isPresented: $isSubsPresented) {
                        PaywallView(paywallId: ApphudPaywallIds.onb.rawValue)
                            .presentationDetents([.height(768)])
                            .presentationCornerRadius(30)
                            .environmentObject(subscriptionManager)
                            .onDisappear{
                                subscriptionManager.didOnb = true
                            }
                    }
                }
                .padding(.horizontal, 29)
            }
            .ignoresSafeArea()
            .frame(height: 381)
            .background(.accent)
            .cornerRadius(30, corners: [.topRight, .topLeft])
            .onChange(of: subscriptionManager.hasSubscription, { oldValue, newValue in
                isSubsPresented = false
            })
            
            VStack {
                if isRemoveBgShown {
                    HStack {
                        Image("magicpenblack")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 29, height: 29)
                        
                        Text("Remove Background")
                            .font(.system(size: 17))
                        
                    }
                    .frame(width: 257, height: 48)
                    .background(.buttonGrayBg)
                    .cornerRadius(20)
                }
                Spacer()
            }
            .frame(height: 381 + 24)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingStep(imageName: "1", title: "Create perfect document photos in seconds!", description: "Prepare photos for passports, visas and IDs in a couple of clicks", description2: "Everything is fully compliant with international standards", description3: "No more wasting time at studios!", buttonText: "Continue", textPadding: 48, isRemoveBgShown: true, currentStep: Binding<Int>.constant(2))
        .environmentObject(SubscriptionManager())
}
