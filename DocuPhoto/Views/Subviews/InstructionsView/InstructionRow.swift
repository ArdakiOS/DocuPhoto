//
//  InstructionRow.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 12.12.2024.
//

import SwiftUI

struct InstructionRow: View {
    var number: Int
    var title: String
    var image1: String
    var image2: String
    
    var body: some View {
        VStack {
            HStack (spacing: 0) {
                Text("\(number)")
                    .font(.system(size: 16))
                    .foregroundStyle(.white)
                    .bold()
                    .background(Circle().fill(.accent).frame(width: 28, height: 28))
                    .padding(.leading, 10)
                    .padding(.top, 5)
                
                Text(LocalizedStringKey(title))
                    .font(.system(size: 15))
                    .fontWeight(.medium)
                    .padding(.leading, 25)
                
                Spacer()
                
            }
            
            HStack (spacing: 17) {
                Image(image1)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                
                Image(image2)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                
            }
            .padding(.top, 5)
        }
        .padding(15)
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
}

#Preview {
    InstructionRow(number: 1, title: "Take off hats and glasses", image1: "inst1", image2: "inst2")
}
