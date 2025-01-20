//
//  CustomAlert.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 21.12.2024.
//

import SwiftUI

struct CustomAlert<Content: View> : View {
    @Binding var showAlert: Bool
    
    var content: Content
    
    init(showAlert: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._showAlert = showAlert
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(showAlert ? 0.5 : 0)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showAlert.toggle()
                    }
                }
            
            ZStack {
                VStack {
                    content
                }
            }
            .opacity(showAlert ? 1 : 0)
            .scaleEffect(showAlert ? 1 : 0)
        }
    }
}

#Preview {
    CustomAlert(showAlert: .constant(true), content: {
        TemplatePopup()
    })
}
