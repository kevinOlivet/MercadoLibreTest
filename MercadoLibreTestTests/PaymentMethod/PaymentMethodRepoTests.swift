//
//  PaymentMethodRepoTests.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import MercadoLibreTest

class PaymentMethodRepoTests: XCTestCase {

    var networker: PaymentMethodRepoProtocol!

    override func setUp() {
        super.setUp()
        networker = Networker() as PaymentMethodRepoProtocol
    }

    override func tearDown() {
        networker = nil
        super.tearDown()
    }

    // Testing the success using mocks
    func testGetPaymentMethodsSuccess() {
        stub(condition: isHost("api.mercadopago.com")) { _ in
            let stubPath = OHPathForFile("paymentMethodData.json", type(of: self))
            return OHHTTPStubsResponse(
                fileAtPath: stubPath!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }

        let expectation = self.expectation(description: "calls the callback with a resource object")

        networker.getPaymentMethods(successCompletion: { (receivedPaymentMethods) in
            XCTAssertEqual(receivedPaymentMethods?.first?.name, "Visa")
            XCTAssertEqual(receivedPaymentMethods?.first?.secureThumbnail, "https://www.mercadopago.com/org-img/MP3/API/logos/visa.gif")
            XCTAssertEqual(receivedPaymentMethods?[1].name, "Mastercard")
            XCTAssertEqual(receivedPaymentMethods?.last?.name, "American Express")
            
            expectation.fulfill()
        }) { (error) in
        }

        self.waitForExpectations(timeout: 0.3, handler: nil)
        OHHTTPStubs.removeAllStubs()
    }

    // Testing it fails with wrong data
    func testGetPaymentMethodsWrongData() {
        stub(condition: isHost("api.mercadopago.com")) { _ in
            let stubPath = OHPathForFile("paymentMethodData.json", type(of: self))
            return OHHTTPStubsResponse(
                fileAtPath: stubPath!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"])
        }

        let expectation = self.expectation(description: "calls the callback with a resource object")

        networker.getPaymentMethods(successCompletion: { (receivedPaymentMethods) in
            XCTAssertNotEqual(receivedPaymentMethods?.first?.name, "wrong")
            XCTAssertNotEqual(receivedPaymentMethods?.first?.secureThumbnail, "wrong")
            XCTAssertNotEqual(receivedPaymentMethods?[1].name, "wrong")
            XCTAssertNotEqual(receivedPaymentMethods?.last?.name, "wrong")

            expectation.fulfill()
        }) { (error) in
        }

        self.waitForExpectations(timeout: 0.3, handler: nil)

        OHHTTPStubs.removeAllStubs()
    }

    // Testing the error block is called with error
    func testGetPaymentMethodsFail() {
        stub(condition: isHost("api.mercadopago.com")) { _ in
            let notConnectedError = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue)
            return OHHTTPStubsResponse(error: notConnectedError)
        }
        let expectation = self.expectation(description: "down network")

        networker.getPaymentMethods(successCompletion: { (receivedPaymentMethods) in
        }) { (error) in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 0.3, handler: nil)
        OHHTTPStubs.removeAllStubs()
    }
}
