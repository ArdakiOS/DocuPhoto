//
//  SettingsRow.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 12.12.2024.
//

import SwiftUI

struct SettingsRow: View {
    var icon: String
    var title: String
    var showArrow: Bool = true
    var boldText: Bool = true

    var body: some View {
        HStack (spacing: 15) {
            Image(icon)
                .resizable()
                .frame(width: 24, height: 24)
            
            
            Text(LocalizedStringKey(title))
                .multilineTextAlignment(.leading)
                .bold(boldText)
                .foregroundColor(.black)
            
            Spacer()
            
            if showArrow {
                Image("arrow-right")
                    .resizable()
                    .frame(width: 15, height: 15)
            }
        }
        .padding(20)
        .background(.accent)
        .cornerRadius(16)
        .padding(.horizontal)
    }
}

#Preview {
    SettingsRow(icon: "export", title: "Share this app")
}
