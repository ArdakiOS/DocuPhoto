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
        }
    }
}

#Preview {
    OnboardingStep(imageName: "1", title: "Create perfect document photos in seconds!", description: "Prepare photos for passports, visas and IDs in a couple of clicks", description2: "Everything is fully compliant with international standards", description3: "No more wasting time at studios!", buttonText: "Continue", textPadding: 48, isRemoveBgShown: true, currentStep: Binding<Int>.constant(4), isSubsPresented: true)
        .environmentObject(ApphudSubsManager())
}

