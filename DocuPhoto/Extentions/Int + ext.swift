//
//  Int + ext.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 16.12.2024.
//

import Foundation

extension Int {
    func makeEven() -> Int {
        return self % 2 == 0 ? self : self - 1
    }
    
    func makeOdd() -> Int {
        return self % 2 != 0 ? self : self + 1
    }
}
