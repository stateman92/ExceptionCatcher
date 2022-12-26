//
//  XCTestExpectation+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 12. 27..
//

import XCTest

extension XCTestExpectation {
    convenience init(description expectationDescription: String, isInverted: Bool) {
        self.init(description: expectationDescription)
        self.isInverted = isInverted
    }
}
