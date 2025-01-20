//
//  ContentView.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 09.12.2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @State private var previousStep = 1
    @EnvironmentObject var subsManager : ApphudSubsManager
    
    var body: some View {
        VStack {
            ZStack {
                getStepView(for: viewModel.currentStep)
                    .transition(getTransition())
            }
        }
        .animation(.easeInOut(duration: 0.2), value: viewModel.currentStep)
        .onChange(of: viewModel.currentStep) { oldStep, newStep in
            previousStep = newStep
        }
        .sheet(isPresented: $viewModel.showingSettings) {
            SettingsView()
                .presentationDetents([.height(660)])
                .presentationCornerRadius(30)
                .environmentObject(viewModel)
                .environmentObject(subsManager)
                .sheet(isPresented: $viewModel.showingInstructions) {
                    InstructionsView()
                        .presentationDetents([.height(748)])
                        .presentationCornerRadius(30)
                }
        }

    }
    
    @ViewBuilder
    private func getStepView(for step: Int) -> some View {
        switch step {
        case 1:
            ImportPhotoStep()
                .environmentObject(viewModel)
        case 2:
            CropStep()
                .environmentObject(viewModel)
        case 3:
            FinishStep()
                .environmentObject(viewModel)
                .environmentObject(subsManager)
        default:
            ImportPhotoStep()
                .environmentObject(viewModel)
        }
    }

    private func getTransition() -> AnyTransition {
        previousStep < viewModel.currentStep ? .move(edge: .trailing) : .move(edge: .leading)
    }
    
}

#Preview {
    MainView()
}
