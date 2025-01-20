//
//  ProgressIndicator.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 09.12.2024.
//

import SwiftUI

struct ProgressIndicator: View {
    @Binding var currentStep: Int
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(1...3, id: \.self) { step in
                ProgressStepView(
                    step: step,
                    currentStep: currentStep,
                    imageName: imageName(for: step),
                    isFirst: step == 1,
                    isLast: step == 3
                )
            }
        }
        .padding(5)
        .background(Color(.systemGray5))
        .cornerRadius(50)
    }
    
    private func imageName(for step: Int) -> String {
        switch step {
        case 1: return "gallery"
        case 2: return "scissor"
        case 3: return "like"
        default: return ""
        }
    }
}

#Preview {
    ProgressIndicator(currentStep: .constant(4))
}
