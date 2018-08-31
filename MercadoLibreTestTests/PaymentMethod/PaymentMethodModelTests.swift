//
//  PaymentMethodModelTests.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import XCTest
@testable import MercadoLibreTest

class PaymentMethodModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testEquatableSuccess() {
        let paymentMethod1 = PaymentMethodModel(name: "test",
                                               paymentId: "test",
                                               secureThumbnail: "test",
                                               paymentTypeId: "test",
                                               minAllowedAmount: 1,
                                               maxAllowedAmount: 50)
        let paymentMethod2 = PaymentMethodModel(name: "test",
                                               paymentId: "test",
                                               secureThumbnail: "test",
                                               paymentTypeId: "test",
                                               minAllowedAmount: 1,
                                               maxAllowedAmount: 50)
        XCTAssertEqual(paymentMethod1, paymentMethod2)
    }

    func testEquatableFail() {
        let paymentMethod1 = PaymentMethodModel(name: "test",
                                                paymentId: "test",
                                                secureThumbnail: "test",
                                                paymentTypeId: "test",
                                                minAllowedAmount: 1,
                                                maxAllowedAmount: 50)
        let paymentMethod2 = PaymentMethodModel(name: "test",
                                                paymentId: "test",
                                                secureThumbnail: "test",
                                                paymentTypeId: "test",
                                                minAllowedAmount: 1,
                                                maxAllowedAmount: 5)
        XCTAssertNotEqual(paymentMethod1, paymentMethod2)
    }
}
