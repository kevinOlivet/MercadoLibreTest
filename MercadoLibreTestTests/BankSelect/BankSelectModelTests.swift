//
//  BankSelectModelTests.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import XCTest
@testable import MercadoLibreTest

class BankSelectModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testEquatableSuccess() {
        let bankSelected1 = BankSelectModel(name: "test",
                                           bankId: "test",
                                           secureThumbnail: "test")
        let bankSelected2 = BankSelectModel(name: "test",
                                           bankId: "test",
                                           secureThumbnail: "test")
        XCTAssertEqual(bankSelected1, bankSelected2)
    }

    func testEquatableFail() {
        let bankSelected1 = BankSelectModel(name: "test",
                                            bankId: "test",
                                            secureThumbnail: "test")
        let bankSelected2 = BankSelectModel(name: "test",
                                            bankId: "test",
                                            secureThumbnail: "NoTest")
        XCTAssertNotEqual(bankSelected1, bankSelected2)
    }
}
