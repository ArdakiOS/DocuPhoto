//
//  DocumentType.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 15.12.2024.
//

import Foundation

struct DocumentType: Identifiable, Hashable {
    let id = UUID()
    let type: DocumentTypeEnum
    var details: DocumentDetails
}
