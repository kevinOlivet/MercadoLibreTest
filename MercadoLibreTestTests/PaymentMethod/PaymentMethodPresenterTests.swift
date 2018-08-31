//
//  PaymentMethodPresenterTests.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import XCTest
@testable import MercadoLibreTest

class PaymentMethodPresenterTests: XCTestCase {

    var presenterUnderTest: PaymentMethodPresenter!

    var mockView: PaymentMethodViewControllerMock!
    var mockRouter: PaymentMethodRouterMock!
    var mockRepo: PaymentMethodRepoMock!

    override func setUp() {
        super.setUp()
        mockView = PaymentMethodViewControllerMock()
        mockRouter = PaymentMethodRouterMock()
        mockRepo = PaymentMethodRepoMock()
        
        presenterUnderTest = PaymentMethodPresenter(view: mockView,
                                                    router: mockRouter,
                                                    repo: mockRepo)
    }

    override func tearDown() {
        mockView = nil
        mockRouter = nil
        mockRepo = nil
        presenterUnderTest = nil
        super.tearDown()
    }

    func testGetPaymentMethods() {
        presenterUnderTest.getPaymentMethods(successCompletion: { (_) in
        }) { (_) in
        }
        XCTAssertTrue(mockRepo.getPaymentMethodsCalled)
    }
    func testHandleDidSelectRowSuccess() {
        presenterUnderTest.paymentMethodArray = [PaymentMethodModel(name: "test",
                                                                    paymentId: "test",
                                                                    secureThumbnail: "test",
                                                                    paymentTypeId: "test",
                                                                    minAllowedAmount: 1,
                                                                    maxAllowedAmount: 50)]
        presenterUnderTest.amountEntered = 25
        presenterUnderTest.handleDidSelectRow(indexPathRow: 0)
        XCTAssertTrue(mockRouter.showBankSelectCalled)
    }
    func testHandleDidSelectRowFail() {
        presenterUnderTest.paymentMethodArray = [PaymentMethodModel(name: "test",
                                                                    paymentId: "test",
                                                                    secureThumbnail: "test",
                                                                    paymentTypeId: "test",
                                                                    minAllowedAmount: 1,
                                                                    maxAllowedAmount: 50)]
        presenterUnderTest.amountEntered = 500
        presenterUnderTest.handleDidSelectRow(indexPathRow: 0)
        XCTAssertFalse(mockRouter.showWrongAmountAlertCalled)
    }
    func testDownloadImage() {
        presenterUnderTest.downloadImage(urlString: "test") { (_) in
        }
        XCTAssertTrue(mockRepo.downloadImageCalled)
    }
    func testshowErrorAlert() {
        presenterUnderTest.showErrorAlert(error: "test")
        XCTAssertFalse(mockRouter.showErrorAlertCalled)
    }
}
