//
//  CuotasModelTests.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import XCTest
@testable import MercadoLibreTest

class CuotasModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testEquatableSuccess() {
        let cuota1 = CuotasModel(installments: 1,
                                 recommendedMessage: "test")
        let cuota2 = CuotasModel(installments: 1,
                                 recommendedMessage: "test")
        XCTAssertEqual(cuota1, cuota2)
    }

    func testEquatableSFail() {
        let cuota1 = CuotasModel(installments: 1,
                                 recommendedMessage: "test")
        let cuota2 = CuotasModel(installments: 1,
                                 recommendedMessage: "NoTest")
        XCTAssertNotEqual(cuota1, cuota2)
    }
}
