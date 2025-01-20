//
//  CropGuideElement.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 14.12.2024.
//

import SwiftUI

struct CropGuideElement: View {
    var isVertical: Bool
    
    var body: some View {
        Capsule()
            .strokeBorder(Color.accent, lineWidth: 2)
            .background(Capsule().fill(Color.white))
            .frame(
                width: isVertical ? 7 : 55,
                height: isVertical ? 55 : 7
            )
    }
}

#Preview {
    CropGuideElement(isVertical: true)
}
