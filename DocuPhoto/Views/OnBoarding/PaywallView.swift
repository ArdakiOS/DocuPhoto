//
//  SubscriptionStep.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 09.12.2024.
//

import SwiftUI
import StoreKit

struct PaywallView: View {
    
    @EnvironmentObject var subscriptionManager: ApphudSubsManager
    @State var paywallId : String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Color.white.ignoresSafeArea()
            Image("bgsubs")
                .resizable()
                .scaledToFit()
            
            VStack(spacing: 16) {
                HStack(alignment: .top){
                    Image(systemName: "xmark")
                        .foregroundStyle(.gray)
                        .font(.title)
                        .fontWeight(.regular)
                        .opacity(0)
                    
                    Spacer()
                    
                    Text("Create perfect document\nphotos in seconds!")
                        .font(.system(size: 24))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button{
                        dismiss()
                    } label : {
                        Image(systemName: "xmark")
                            .foregroundStyle(.gray)
                            .font(.system(size: 24))
                            .fontWeight(.medium)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 25)
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
                    ForEach(Array(subscriptionManager.products), id: \.self) {product in
                        Button(action: {
                            subscriptionManager.highlightedProdcut = product.skProduct
                            subscriptionManager.selectedProduct = product.appHudProduct
                        }, label: {
                            PricingOption(
                                product: product.skProduct,
                                isHighlighted: subscriptionManager.highlightedProdcut == product.skProduct
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
                        .background(.newOnbBg)
                        .cornerRadius(25)
                }
                .padding(.horizontal)
                
                
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
            .padding(.bottom, 15)
        }
        
        .ignoresSafeArea()
        .onAppear{
            subscriptionManager.getPayWallProducts(id: paywallId)
            print("paywallId \(paywallId)")
        }
    }
}

#Preview {
    OnboardingStep(imageName: "1", title: "Create perfect document photos in seconds!", description: "Prepare photos for passports, visas and IDs in a couple of clicks", description2: "Everything is fully compliant with international standards", description3: "No more wasting time at studios!", buttonText: "Continue", textPadding: 48, isRemoveBgShown: true, currentStep: Binding<Int>.constant(4), isSubsPresented: true)
        .environmentObject(ApphudSubsManager())
}

struct PricingOption: View {
    var product: Product
    var isHighlighted: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                if let duration = getSubscriptionDuration(for: product) {
                    Text("\(product.displayPrice) / \(duration)")
                        .font(.system(size: 16).weight(.medium))
                        .foregroundColor(.black)
                }
                Spacer()
                if product.id == "year.prem" {
                    
                    Text("Best choice!")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                    + Text("\nsale 75%")
                        .font(.system(size: 14))
                        .bold()
                        .foregroundColor(.black)
                    
                }
            }
            .padding(16)
            .frame(height: 64)
            .background(isHighlighted ? Color.newOnbBg : Color.background1)
            .cornerRadius(15)
            .multilineTextAlignment(.center)
        }
    }
    
    func getSubscriptionDuration(for product: Product) -> String? {
        // Check if the product is a subscription
        if let subscription = product.subscription {
            // Access the subscription period (e.g., week, month, year)
            let period = subscription.subscriptionPeriod
            let unit = period.unit
            
            // Format the duration as a human-readable string
            switch unit {
            case .day:
                return "day"
            case .week:
                return "week"
            case .month:
                return "month"
            case .year:
                return "year"
            @unknown default:
                return "Unknown subscription unit"
            }
        }
        
        // If the product is not a subscription
        return nil
    }
}

struct FeauturesElement: View {
    var title: String
    var body: some View {
        HStack (spacing: 3) {
            Image("tick-circle")
                .resizable()
                .frame(width: 20, height: 20)
                .scaledToFill()
            
            Text(LocalizedStringKey(title))
                .font(.system(size: 12))
        }
        .frame(width: 150, alignment: .leading)
        
    }
}
