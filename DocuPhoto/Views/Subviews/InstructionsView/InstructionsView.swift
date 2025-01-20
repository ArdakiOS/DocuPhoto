//
//  InstructionsView.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 12.12.2024.
//

import SwiftUI

struct InstructionsView: View {
  
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack (alignment: .topTrailing) {
            
            ScrollView (showsIndicators: false) {
                VStack (spacing: 3.5) {
                    
                    
                    VStack (spacing: 30) {
                        
                        Text("Instructions")
                            .font(.system(size: 18))
                            .bold()
                        
                        InstructionRow(number: 1, title: "Take off hats and glasses", image1: "inst1", image2: "inst2")
                        
                        InstructionRow(number: 2, title: "Use a photo with a plain background", image1: "inst3", image2: "inst2")
                        
                        InstructionRow(number: 3, title: "Ensure no shadows on the face", image1: "inst4", image2: "inst2")
                    }
                    .padding(.horizontal, 35)
                }
                .padding(.top, 45)


            }
            
            Button(action: {
                dismiss()
            }, label: {
                HStack {
                    Spacer()
                    Image("close")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .padding(.top, 25)
                        .padding(.trailing, 25)
                        .opacity(0.5)
                }
            })
        }
    }
}


#Preview {
    InstructionsView()
}
