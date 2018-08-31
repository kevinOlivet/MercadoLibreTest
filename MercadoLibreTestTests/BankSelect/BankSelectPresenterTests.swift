//
//  BankSelectPresenterTests.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import XCTest
@testable import MercadoLibreTest

class BankSelectPresenterTests: XCTestCase {

    var presenterUnderTest: BankSelectPresenter!

    var mockView: BankSelectViewControllerMock!
    var mockRouter: BankSelectRouterMock!
    var mockRepo: BankSelectRepoMock!

    override func setUp() {
        super.setUp()
        mockView = BankSelectViewControllerMock()
        mockRouter = BankSelectRouterMock()
        mockRepo = BankSelectRepoMock()

        presenterUnderTest = BankSelectPresenter(view: mockView,
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

    func testGetBankSelectFail() {
        presenterUnderTest.getBankSelect(successCompletion: { (_) in
        }) { (_) in
        }
        XCTAssertFalse(mockRepo.getBankSelectCalled)
    }

    func testGetBankSelectSuccess() {
        presenterUnderTest.selectedPaymentMethod = PaymentMethodModel(name: "test",
                                                                      paymentId: "test",
                                                                      secureThumbnail: "test",
                                                                      paymentTypeId: "test",
                                                                      minAllowedAmount: 1,
                                                                      maxAllowedAmount: 50)
        presenterUnderTest.getBankSelect(successCompletion: { (_) in
        }) { (_) in
        }
        XCTAssertTrue(mockRepo.getBankSelectCalled)
    }

    func testHandleDidSelectItem() {
        presenterUnderTest.selectedPaymentMethod = PaymentMethodModel(name: "test",
                                                                      paymentId: "test",
                                                                      secureThumbnail: "test",
                                                                      paymentTypeId: "test",
                                                                      minAllowedAmount: 1,
                                                                      maxAllowedAmount: 50)
        presenterUnderTest.amountEntered = 25
        presenterUnderTest.handleDidSelectItem(indexPathItem: 0)
        XCTAssertTrue(mockRouter.showCuotasCalled)
    }

    func testDownloadImage() {
        presenterUnderTest.downloadImage(urlString: "test") { (_) in
        }
        XCTAssertTrue(mockRepo.downloadImageCalled)
    }

    func testShowErrorAlert() {
        presenterUnderTest.showErrorAlert(error: "test")
        XCTAssertTrue(mockRouter.showErrorAlertCalled)
    }
}
