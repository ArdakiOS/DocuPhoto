//
//  ProgressStepView.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 09.12.2024.
//

import SwiftUI

struct ProgressStepView: View {
    let step: Int
    let currentStep: Int
    let imageName: String
    let isFirst: Bool
    let isLast: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(currentStep >= step ? .darkAccent : Color(.systemGray6))
                .frame(height: 55)
                .cornerRadius(isFirst ? 46 : 10, corners: [.topLeft, .bottomLeft])
                .cornerRadius(isLast ? 46 : 10, corners: [.topRight, .bottomRight])
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .frame(width: 24, height: 24)
                .padding(8)
                .foregroundColor(currentStep >= step ? .black : .gray)
                .background(Circle().fill(step == currentStep ? Color.accentColor : Color.clear))
        }
    }
}


#Preview {
    ProgressStepView(step: 1, currentStep: 1, imageName: "like", isFirst: true, isLast: false)
}
