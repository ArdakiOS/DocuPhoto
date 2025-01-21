//
//  LoadingVIew.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 25.12.2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Image("icon")
                .resizable()
                .frame(width: 155, height: 155)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

#Preview {
    LoadingView()
}
