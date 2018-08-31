//
//  BankSelectRepoTests.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import MercadoLibreTest

class BankSelectRepoTests: XCTestCase {

    var networker: BankSelectRepoProtocol!

    override func setUp() {
        super.setUp()
        networker = Networker() as BankSelectRepoProtocol
    }

    override func tearDown() {
        networker = nil
        super.tearDown()
    }

    // Testing the success using mocks
    func testGetBankSelectSuccess() {
        stub(condition: isHost("api.mercadopago.com")) { _ in
            let stubPath = OHPathForFile("bankSelectData.json", type(of: self))
            return OHHTTPStubsResponse(
                fileAtPath: stubPath!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }

        let expectation = self.expectation(description: "calls the callback with a resource object")

        networker.getBankSelect(selectedPaymentMethodId: "visa", successCompletion: { (receivedBankSelectModels) in
            XCTAssertEqual(receivedBankSelectModels?.first?.name, "Tarjeta Shopping")
            XCTAssertEqual(receivedBankSelectModels?.first?.bankId, "288")
            XCTAssertEqual(receivedBankSelectModels?[1].name, "Banco Galicia")
            XCTAssertEqual(receivedBankSelectModels?.last?.name, "Banco Industrial")

            expectation.fulfill()
        }) { (error) in
        }

        self.waitForExpectations(timeout: 0.3, handler: nil)
        OHHTTPStubs.removeAllStubs()
    }

    // Testing it fails with wrong data
    func testGetBankSelectWrongData() {
        stub(condition: isHost("api.mercadopago.com")) { _ in
            let stubPath = OHPathForFile("bankSelectData.json", type(of: self))
            return OHHTTPStubsResponse(
                fileAtPath: stubPath!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"])
        }

        let expectation = self.expectation(description: "calls the callback with a resource object")

        networker.getBankSelect(selectedPaymentMethodId: "visa", successCompletion: { (receivedBankSelectModels) in
            XCTAssertNotEqual(receivedBankSelectModels?.first?.name, "wrong")
            XCTAssertNotEqual(receivedBankSelectModels?.first?.bankId, "wrong")
            XCTAssertNotEqual(receivedBankSelectModels?[1].name, "wrong")
            XCTAssertNotEqual(receivedBankSelectModels?.last?.name, "wrong")

            expectation.fulfill()
        }) { (error) in
        }

        self.waitForExpectations(timeout: 0.3, handler: nil)
        OHHTTPStubs.removeAllStubs()
    }

    // Testing the error block is called with error
    func testGetBankSelectFail() {
        stub(condition: isHost("api.mercadopago.com")) { _ in
            let notConnectedError = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue)
            return OHHTTPStubsResponse(error: notConnectedError)
        }
        let expectation = self.expectation(description: "down network")

        networker.getBankSelect(selectedPaymentMethodId: "visa", successCompletion: { (receivedBankSelectModels) in
        }) { (error) in
            print("Here is the error: ", error)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 0.3, handler: nil)
        OHHTTPStubs.removeAllStubs()
    }
}
