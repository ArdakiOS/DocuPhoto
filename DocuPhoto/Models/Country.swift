//
//  Country.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 15.12.2024.
//

import Foundation

struct Country: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var flag: String
    var documentTypes: [DocumentType]
    
    var displayName: String {
        "\(flag) \(name)"
    }
}
