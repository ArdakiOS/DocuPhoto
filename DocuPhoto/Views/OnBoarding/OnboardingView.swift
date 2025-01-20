//
//  OnboardingView.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 09.12.2024.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var subscriptionManager: ApphudSubsManager
    @State private var currentStep = 1

    var body: some View {
        TabView(selection: $currentStep) {
            
            OnboardingStep(
                imageName: "1",
                title: "Create perfect document photos in seconds!",
                description: "Prepare photos for passports, visas and IDs in a couple of clicks",
                description2: "Everything is fully compliant with international standards",
                description3: "No more wasting time at studios!",
                buttonText: "Continue",
                currentStep: $currentStep
            )
            .tag(1)

            OnboardingStep(
                imageName: "2",
                title: "Customize background to your needs",
                description: "Remove the background or change its color",
                description2: "Choose from the available options (white, gray and others)",
                description3: "Perfect result in a couple of seconds",
                buttonText: "Continue",
                textPadding: 48,
                isRemoveBgShown: true,
                currentStep: $currentStep
            )
            .tag(2)

            OnboardingStep(
                imageName: "3",
                title: "Export and print photos with ease",
                description: "Save your finished photos in JPEG and PDF formats",
                description2: "One-touch printing via AirPrint",
                description3: "Preparing photos has never been easier!",
                buttonText: "Continue",
                textPadding: 48,
                currentStep: $currentStep
            )
            .tag(3)
            .environmentObject(subscriptionManager)

        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.easeInOut(duration: 1.0), value: currentStep)
        .transition(.slide)
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingView()
        .environmentObject(SubscriptionManager())
}
