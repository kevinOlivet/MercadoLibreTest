//
//  CuotasRepoTests.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import MercadoLibreTest

class CuotasRepoTests: XCTestCase {

    var networker: CuotasRepoProtocol!

    override func setUp() {
        super.setUp()
        networker = Networker() as CuotasRepoProtocol
    }

    override func tearDown() {
        networker = nil
        super.tearDown()
    }

    // Testing the success using mocks
    func testGetCuotasSuccess() {
        stub(condition: isHost("api.mercadopago.com")) { _ in
            let stubPath = OHPathForFile("cuotasData.json", type(of: self))
            return OHHTTPStubsResponse(
                fileAtPath: stubPath!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }

        let expectation = self.expectation(description: "calls the callback with a resource object")

        networker.getCuotas(amountEntered: 100000, selectedPaymentMethodId: "visa", bankSelectedId: "288", successCompletion: { (cuotas) in
            XCTAssertEqual(cuotas?.first?.installments, 1)
            XCTAssertEqual(cuotas?.first?.recommendedMessage, "1 cuota de $ 100.000,00 ($ 100.000,00)")
            XCTAssertEqual(cuotas?[1].recommendedMessage, "3 cuotas de $ 37.973,33 ($ 113.920,00)")
            XCTAssertEqual(cuotas?.last?.recommendedMessage, "12 cuotas de $ 12.770,00 ($ 153.240,00)")

            expectation.fulfill()
        }) { (error) in
        }

        self.waitForExpectations(timeout: 0.3, handler: nil)
        OHHTTPStubs.removeAllStubs()
    }

    // Testing it fails with wrong data
    func testGetCuotastWrongData() {
        stub(condition: isHost("api.mercadopago.com")) { _ in
            let stubPath = OHPathForFile("cuotasData.json", type(of: self))
            return OHHTTPStubsResponse(
                fileAtPath: stubPath!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"])
        }

        let expectation = self.expectation(description: "calls the callback with a resource object")

        networker.getCuotas(amountEntered: 100000, selectedPaymentMethodId: "visa", bankSelectedId: "288", successCompletion: { (cuotas) in
            XCTAssertNotEqual(cuotas?.first?.installments, 2)
            XCTAssertNotEqual(cuotas?.first?.recommendedMessage, "wrong")
            XCTAssertNotEqual(cuotas?[1].recommendedMessage, "wrong")
            XCTAssertNotEqual(cuotas?.last?.recommendedMessage, "wrong")
            
            expectation.fulfill()
        }) { (error) in
        }

        self.waitForExpectations(timeout: 0.3, handler: nil)
        OHHTTPStubs.removeAllStubs()
    }

    // Testing the error block is called with error
    func testCuotasFail() {
        stub(condition: isHost("api.mercadopago.com")) { _ in
            let notConnectedError = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue)
            return OHHTTPStubsResponse(error: notConnectedError)
        }
        let expectation = self.expectation(description: "down network")

        networker.getCuotas(amountEntered: 100000, selectedPaymentMethodId: "visa", bankSelectedId: "288", successCompletion: { (cuotas) in
        }) { (error) in
            print("Here is the error: ", error)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 0.3, handler: nil)
        OHHTTPStubs.removeAllStubs()
    }
}
