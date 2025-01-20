//
//  Enums.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 14.12.2024.
//

import Foundation

enum SelectedLine {
    case head
    case eyes
    case chin
}

enum DocumentTypeEnum: String, CaseIterable {
    case passport = "Passport"
    case visa = "Visa"
    case custom = "Custom"
}
