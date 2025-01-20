//
//  DocumentInfo.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 14.12.2024.
//

import Foundation
import SwiftUICore

struct DocumentDetails: Identifiable, Hashable {
    let id = UUID()
    var photoWidth: Int
    var photoHeight: Int
    var backgroundColor: Color
    var dpi: Int
}
