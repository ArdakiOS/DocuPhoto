//
//  ImportButtonLabel.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 09.12.2024.
//

import SwiftUI

struct ImportButtonLabel: View {
    var image: String
    var text: String
    
    var body: some View {
        HStack (spacing: 10) {
            Image(image)
                .resizable()
                .frame(width: 24, height: 24)
            
            Text(text)
                .font(.system(size: 14))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(15)
        .background(.accent)
        .frame(height: 54)
        .cornerRadius(16, corners: .allCorners)
    }
}

#Preview {
    ImportButtonLabel(image: "gallery-add", text: "Select from Gallery")
}
