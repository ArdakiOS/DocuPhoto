//
//  SizeListView.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 14.12.2024.
//

import SwiftUI

struct CountryListView: View {
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
            
            Text("Countries")
                .font(.system(size: 18).bold())
                .padding(.top, 25)
            
            TextField("Search", text: $searchText)
                .textFieldStyle(CustomTextFieldStyle(backgroundColor: .black.opacity(0.05)))
                .padding(.horizontal, 17)
                .padding(.top, 27)
            
            ForEach(filteredCountries) { country in
                
                Button(action: {
                    viewModel.selectCountry(country: country)
                    dismiss()
                }) {
                    HStack {
                        
                        Text(country.displayName)
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
        .onDisappear {
            dismiss()
        }
    }
    
    private var filteredCountries: [Country] {
        if searchText.isEmpty {
            return viewModel.countries
        } else {
            return viewModel.countries.filter { country in
                country.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
}


#Preview {
    CountryListView()
        .environmentObject(MainViewModel())
}
