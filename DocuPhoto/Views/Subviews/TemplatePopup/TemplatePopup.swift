//
//  TemplatePopup.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 14.12.2024.
//

import SwiftUI

struct TemplatePopup: View {
    @EnvironmentObject var viewModel: MainViewModel
    @State var isCountryListVisible: Bool = false
    @State var isDocumentListVisible: Bool = false
    var body: some View {
        VStack(spacing: 0) {

            HStack (spacing: 5) {
                Text(viewModel.selectedCountry.flag)
                    .frame(width: 24, height: 24)
                    
                Text("\(viewModel.selectedDocument.type.rawValue) \(Int(viewModel.selectedDocument.details.photoWidth))x\(Int(viewModel.selectedDocument.details.photoHeight))mm")
                    .font(.system(size: 14).bold())
                
                Spacer()

                Button(action: {
                    viewModel.showingEditTemplate.toggle()
                }) {
                    
                    HStack (spacing: 7){
                        Text("Edit")
                            .font(.system(size: 14).bold())
                            .foregroundColor(.black)
                        
                        Image("format-square")
                            .resizable()
                            .frame(width: 17, height: 17)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(Capsule().fill(.accent))
                    .cornerRadius(8)
                }
            }
            .padding(15)
            .sheet(isPresented: $viewModel.showingEditTemplate) {
                EditTemplateView()
                    .presentationDetents([.height(812)])
                    .presentationCornerRadius(30)
            }
            
            HStack {
                
                Button {
                    isCountryListVisible.toggle()
                } label: {
                    HStack (spacing: 5) {
                        Text(viewModel.selectedCountry.name)
                            .font(.system(size: 14).weight(.regular))
                        
                        Image("arrow-right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                            .rotationEffect(.degrees(90))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .padding(.horizontal, 8)
                    .background(Rectangle()
                        .foregroundStyle(Color.black.opacity(0.05))
                        .cornerRadius(46, corners: [.topLeft, .bottomLeft])
                        .cornerRadius(10, corners: [.topRight, .bottomRight]))
                    .foregroundStyle(.black)
                    .cornerRadius(8)
                }
                .sheet(isPresented: $isCountryListVisible) {
                    CountryListView()
                        .environmentObject(viewModel)
                        .presentationDetents([.height(660)])
                        .presentationCornerRadius(30)
                 }
                
                Button {
                    isDocumentListVisible.toggle()
                } label: {
                    HStack (spacing: 5) {
                        Text("\(viewModel.selectedDocument.type.rawValue) \(Int(viewModel.selectedDocument.details.photoWidth))x\(Int(viewModel.selectedDocument.details.photoHeight))mm")
                            .font(.system(size: 14).weight(.regular))

                        Image("arrow-right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                            .rotationEffect(.degrees(90))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .padding(.horizontal, 8)
                    .background(Rectangle()
                        .foregroundStyle(Color.black.opacity(0.05))
                        .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                        .cornerRadius(46, corners: [.topRight, .bottomRight]))
                    .foregroundStyle(.black)
                    .cornerRadius(8)
                }
                .sheet(isPresented: $isDocumentListVisible) {
                    DocumentListView()
                        .environmentObject(viewModel)
                        .presentationDetents([.height(660)])
                        .presentationCornerRadius(30)
                 }
            }
            .padding(.top, 5)
            
        }
        .padding(5)
        .background(.white)
        .cornerRadius(29)
        .padding(20)
    }
}

#Preview {
    TemplatePopup()
        .environmentObject(MainViewModel())
}
