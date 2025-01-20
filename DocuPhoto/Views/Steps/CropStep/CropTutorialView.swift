//
//  CropTutorial.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 12.12.2024.
//

import SwiftUI

struct CropTutorialView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack (spacing: 0) {
            
            Capsule()
                .fill(Color.gray)
                        .frame(width: 120, height: 5)
                        .edgesIgnoringSafeArea(.horizontal)
                        .padding(.top, 20)
            
            Text("Crop Tutorial")
                .font(.system(size: 18))
                .bold()
                .padding(.top, 25)
            
            Spacer()
            
            Image("cropguide")
                .resizable()
                .scaledToFit()
                .frame(width: 311.4, height: 200)
            
            VStack {
                SettingsRow(icon: "info-black", title: "Ensure the photo captures the entire head, from the top of the hair to the bottom of the chin", showArrow: false, boldText: false)
                SettingsRow(icon: "info-black", title: "Align the head in the center of the frame", showArrow: false, boldText: false)
                SettingsRow(icon: "info-black", title: "The individual should have a neutral expression and face the camera directly.", showArrow: false, boldText: false)
            }
            .padding(.top, 15)
            
            Spacer()

            
            Button(action: {
                dismiss()
            }) {
                Text("Close")
                    .bold()
                    .frame(width: 165, height: 46)
                    .background(.accent)
                    .foregroundColor(.black)
                    .cornerRadius(25)
                
            }
            .frame(width: 165)
            
            Spacer()
        }
    }
}

#Preview {
    CropTutorialView()
}
