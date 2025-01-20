//
//  DocumentsListView.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 15.12.2024.
//

import SwiftUI

struct DocumentListView: View {
    @EnvironmentObject var viewModel: MainViewModel
    @Environment(\.dismiss) var dismiss
    @State var searchText: String = ""
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            
            Capsule()
                .fill(Color.gray)
                        .frame(width: 120, height: 5)
                        .edgesIgnoringSafeArea(.horizontal)
                        .padding(.top, 20)
            
            Text("Sizes")
                .font(.system(size: 18).bold())
                .padding(.top, 25)
            
            VStack {
                
                ForEach(viewModel.selectedCountry.documentTypes, id: \.id) { document in
                    
                    Button(action: {
                        viewModel.selectDocument(document: document)
                        dismiss()
                    }) {
                        HStack {
                            
                            Text(document.type.rawValue)
                                .bold()
                                .foregroundColor(.black)
                            
                            Text("\(document.details.photoWidth) x \(document.details.photoHeight) mm")
                                            .bold()
                                            .foregroundColor(.black)
                            
                            Spacer()
                            
                            Image("arrow-right")
                                .resizable()
                                .frame(width: 15, height: 15)
                        }
                        .padding(20)
                        .background(.black.opacity(0.05))
                        .cornerRadius(16)
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.top, 45)
        }
        .onDisappear {
            dismiss()
        }
    }
}

#Preview {
    DocumentListView()
        .environmentObject(MainViewModel())
}
