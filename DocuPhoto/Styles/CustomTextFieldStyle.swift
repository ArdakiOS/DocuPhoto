//
//  TextFieldStyle.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 15.12.2024.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    @FocusState private var textFieldFocused: Bool
    var backgroundColor: Color
    var cornerRadius: CGFloat = 30
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(20)
            .disableAutocorrection(true)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius).stroke(.blue, lineWidth: 0))
            .focused($textFieldFocused)
            .onTapGesture {
                textFieldFocused = true
            }
    }
}
