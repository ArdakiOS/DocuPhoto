//
//  SubscriptionStep.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 09.12.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var subscriptionManager = ApphudSubsManager()
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Image("bgsubs")
                .resizable()
                .scaledToFit()
            
            
            VStack(spacing: 16) {
                Text("Create perfect document photos in seconds!")
                    .font(.system(size: 24))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.horizontal, 58)
                    .padding(.bottom, 15)
                
                Image("subsPic")
                    .resizable()
                    .scaledToFit()
                    .padding(.trailing, -20)
                    .padding(.leading)
                
                
                VStack (spacing: 7) {
                    HStack (spacing: 16) {
                        FeauturesElement(title: "Automatic adjustment")
                        
                        FeauturesElement(title: "AirPrint-ready setup")
                    }
                    HStack (spacing: 16) {
                        FeauturesElement(title: "Perfect fit for printing")
                        FeauturesElement(title: "Background setting")
                    }
                }
                
                VStack(spacing: 10) {
                    ForEach(Array(subscriptionManager.products), id: \.key) { key, product in
                        Button(action: {
                            subscriptionManager.highlightedProdcut = product
                            subscriptionManager.selectedProduct = key
                        }, label: {
                            PricingOption(
                                product: product,
                                isHighlighted: subscriptionManager.highlightedProdcut == product
                            )
                        })
                    }
                }
                .padding(.horizontal)
                .frame(minHeight: 200)
                
                
                
                VStack (spacing: 2){
                    
                    Text("By subscribing, you agree to our")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    HStack(spacing: 0) {
                        Link(destination: URL(string: "https://telegra.ph/Terms-of-Use-12-25-3")!) {
                            Text("Terms of Use")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .underline()
                        }
                        
                        Text(" & ")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                        
                        Link(destination: URL(string: "https://telegra.ph/Privacy-Policy-12-25-97")!) {
                            Text("Privacy Policy")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .underline()
                        }
                    }
                }
                
                Button(action: {
                    subscriptionManager.makePruchase()
                }) {
                    Text("Subscribe and get started now!")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(.accent)
                        .cornerRadius(25)
                }
                .padding(.horizontal)
                
                if subscriptionManager.hasSubscription {
                    Text("HAS SUBSCRIPTION")
                        .font(.largeTitle)
                        .foregroundStyle(.red)
                }
                Button(action: {
                    
                    subscriptionManager.restorePurchase()
                    
                }) {
                    Text("Restore purchases")
                        .underline()
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                }
                .padding(.bottom, 15)
                .alert(subscriptionManager.alertTitle ?? "", isPresented: $subscriptionManager.alertIsPresented) {
                    Button("OK") { subscriptionManager.alertIsPresented = false
                        subscriptionManager.alertTitle = nil
                        subscriptionManager.alertMessage = nil
                    }
                }
                
            }
        }
        .ignoresSafeArea()
        .onAppear {
            subscriptionManager.getPayWallProducts(id: "onb_paywall")
        }
    }
}

#Preview {
    OnboardingStep(imageName: "1", title: "Create perfect document photos in seconds!", description: "Prepare photos for passports, visas and IDs in a couple of clicks", description2: "Everything is fully compliant with international standards", description3: "No more wasting time at studios!", buttonText: "Continue", textPadding: 48, isRemoveBgShown: true, currentStep: Binding<Int>.constant(4), isSubsPresented: true)
        .environmentObject(SubscriptionManager())
}

