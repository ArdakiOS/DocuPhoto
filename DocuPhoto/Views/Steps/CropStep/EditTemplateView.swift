//
//  EditTemplateView.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 18.12.2024.
//

import SwiftUI

struct EditTemplateView: View {
    
    @EnvironmentObject var viewModel: MainViewModel
    @Environment(\.dismiss) var dismiss
    @State var topLineOffset: CGFloat = 30
    @State var bottomLineOffset: CGFloat = 130
    
    @State var frameWidth: CGFloat = 35
    @State var frameHeight: CGFloat = 40
    @State var selectedLine: SelectedLine = .head
    
    @State var custom = Country(name: "Custom", flag: "🏳️", documentTypes: [
        DocumentType(type: .custom, details: DocumentDetails(photoWidth: 35, photoHeight: 40, backgroundColor: .white, dpi: 600))
    ])
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        return formatter
    }()
    
    @State var guideTopPerc: CGFloat = 20
    @State var guideBottomPerc: CGFloat = 20
    
    var body: some View {
        
        VStack {
            Capsule()
                .fill(Color.gray)
                        .frame(width: 120, height: 5)
                        .edgesIgnoringSafeArea(.horizontal)
                        .padding(.top, 20)
            
            Text("Photo Size")
                .font(.system(size: 18).weight(.semibold))
                .padding(.top, 25)
            
            VStack (spacing: 0) {
                
                VStack {
                    EditTemplateFaceRuler(
                        topLineOffset: $topLineOffset,
                        bottomLineOffset: $bottomLineOffset,
                        frameWidth: $frameWidth,
                        frameHeight: $frameHeight,
                        selectedLine: $selectedLine,
                        cropSize: $viewModel.cropSize,
                        topPerc: $guideTopPerc,
                        bottomPerc: $guideBottomPerc
                    )
                }
                .frame(height: 186)
               
                
                HStack {
                    Button(action: {
                        selectedLine = .head
                    }, label: {
                        Text("Head")
                            .font(.system(size: 14))
                            .frame(width: 102, height: 33)
                            .bold()
                            .foregroundStyle(selectedLine == .head ? .black : .gray)
                            .background(selectedLine == .head ? .darkAccent : .black.opacity(0.16))
                            .cornerRadius(16, corners: [.topLeft, .bottomLeft])
                            .cornerRadius(10, corners: [.topRight, .bottomRight])
                    })
                    
                    Button(action: {
                        selectedLine = .eyes
                    }, label: {
                        Text("Eyes")
                            .font(.system(size: 14))
                            .frame(width: 102, height: 33)
                            .bold()
                            .foregroundStyle(selectedLine == .eyes ? .black : .gray)
                            .background(selectedLine == .eyes ? .darkAccent : .black.opacity(0.16))
                            .cornerRadius(10)
                    })
                    
                    Button(action: {
                        selectedLine = .chin
                    }, label: {
                        Text("Chin")
                            .font(.system(size: 14))
                            .frame(width: 102, height: 33)
                            .bold()
                            .foregroundStyle(selectedLine == .chin ? .black : .gray)
                            .background(selectedLine == .chin ? .darkAccent : .black.opacity(0.16))
                            .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                            .cornerRadius(16, corners: [.topRight, .bottomRight])
                    })
                }
                .padding(.top, 20)
                
                HStack (spacing: 5) {
                    Text("Width")
                        .font(.system(size: 14).weight(.medium))
                        .padding(.trailing, 9)
                    
                    TextField("", value: $frameWidth, formatter: formatter)
                        .font(.system(size: 14))
                        .padding()
                        .frame(width: 135, height: 37)
                        .bold()
                        .multilineTextAlignment(.trailing)
                        .background(.black.opacity(0.1))
                        .cornerRadius(16, corners: [.topLeft, .bottomLeft])
                        .cornerRadius(10, corners: [.topRight, .bottomRight])
                        .keyboardType(.decimalPad)
                        .onChange(of: frameWidth) { old, newValue in
                            
                            if newValue > 99 {
                                frameWidth = 99
                            }
                        }
                    
                    Text("mm")
                        .font(.system(size: 14))
                        .frame(width: 73, height: 37)
                        .bold()
                        .foregroundStyle(.gray)
                        .background(.black.opacity(0.16))
                        .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                        .cornerRadius(16, corners: [.topRight, .bottomRight])
                }
                .padding(.horizontal, 53)
                .padding(.top, 45)
                
                HStack (spacing: 5) {
                    Text("Height")
                        .font(.system(size: 14).weight(.medium))
                        .padding(.trailing, 9)
                    
                    TextField("", value: $frameHeight, formatter: formatter)
                        .font(.system(size: 14))
                        .padding()
                        .frame(width: 135, height: 37)
                        .bold()
                        .multilineTextAlignment(.trailing)
                        .background(.black.opacity(0.1))
                        .cornerRadius(16, corners: [.topLeft, .bottomLeft])
                        .cornerRadius(10, corners: [.topRight, .bottomRight])
                        .keyboardType(.decimalPad)
                        .onChange(of: frameWidth) { old, newValue in
    
                            if newValue > 99 {
                                frameWidth = 99
                            }
                        }
                    
                    Text("mm")
                        .font(.system(size: 14))
                        .frame(width: 73, height: 37)
                        .bold()
                        .foregroundStyle(.gray)
                        .background(.black.opacity(0.16))
                        .cornerRadius(10, corners: [.topLeft, .bottomLeft])
                        .cornerRadius(16, corners: [.topRight, .bottomRight])
                }
                .padding(.horizontal, 35)
                .padding(.top, 10)
           
            }
            .padding(.top, 5)
            
            Spacer()
            
            HStack (spacing: 15) {
                
                Button(action: {
                    
                    viewModel.selectCountry(country: viewModel.selectedCountry)
                    dismiss()
                }) {
                    Text("Discard")
                        .bold()
                        .frame(width: 125, height: 46)
                        .background(.black.opacity(0.05))
                        .foregroundColor(.gray)
                        .cornerRadius(25)
                }
                
                
                Button(action: {
                    custom.documentTypes[0].details.photoWidth = Int(frameWidth)
                    custom.documentTypes[0].details.photoHeight = Int(frameHeight)

                    
                    viewModel.topOffset = viewModel.cropSize.height * guideTopPerc
                    print(viewModel.topOffset)
                    viewModel.bottomOffset = viewModel.cropSize.height * guideBottomPerc
                    print(viewModel.bottomOffset)
                    
                    viewModel.selectCountry(country: custom)
                    dismiss()
                }) {
                    Text("Save Guide")
                        .bold()
                        .frame(width: 165, height: 46)
                        .background(.accent)
                        .foregroundColor(.black)
                        .cornerRadius(25)  
                }
            }
            .padding(.bottom, 25)
            
        }
        .onAppear {
            frameWidth = CGFloat(viewModel.selectedDocument.details.photoWidth)
            frameHeight = CGFloat(viewModel.selectedDocument.details.photoHeight)
            custom.documentTypes[0].details = viewModel.selectedDocument.details
            print(viewModel.cropSize)
        }
    }
}

#Preview {
    EditTemplateView()
        .environmentObject(MainViewModel())
}
