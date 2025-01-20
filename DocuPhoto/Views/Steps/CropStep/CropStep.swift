//
//  TestView3.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 13.12.2024.
//

import SwiftUI

struct CropStep: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        ZStack {
            VStack (spacing: 0) {
                ProgressIndicator(currentStep: $viewModel.currentStep)
                    .padding(.horizontal)
                    .padding(.top, 26)
                
                Spacer()
                
                CropView(topOffset: .constant(00), bottomOffset: $viewModel.bottomOffset) { croppedImage, status in
                    if let croppedImage {
                        viewModel.croppedImage = croppedImage
                        viewModel.currentStep += 1
                    }
                }
                .environmentObject(viewModel)
            }
            .blur(radius: viewModel.showingTemplatePopup ? 4 : 0)
            
            
            CustomAlert(showAlert: $viewModel.showingTemplatePopup, content: {
                
                TemplatePopup()
            })
        }
        .background(viewModel.gradient)
        .animation(.easeInOut, value: viewModel.showingTemplatePopup)
    }
}

#Preview {
    CropStep()
        .environmentObject(MainViewModel())
}
