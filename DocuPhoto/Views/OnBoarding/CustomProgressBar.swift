//
//  CustomProgressBar.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 09.12.2024.
//

import SwiftUI

struct CustomProgressBar: View {
    var totalSteps: Int = 4 // Total number of steps
    var currentStep: Int = 3 // Current active step (1-based index)
    
    var body: some View {
        HStack(spacing: 12) { // Adjust spacing as needed
            ForEach(1..<totalSteps + 1, id: \.self) { index in
                Circle()
                    .fill(index == currentStep ? Color.black : Color.black.opacity(0.2))
                    .frame(
                        width: index == currentStep ? 16 : 6, // Larger size for current step
                        height: index == currentStep ? 16 : 6  // Match height to width
                    )
                    .animation(.easeInOut, value: currentStep) // Smooth animation on change
            }
        }
    }
}

#Preview {
    CustomProgressBar()
}
