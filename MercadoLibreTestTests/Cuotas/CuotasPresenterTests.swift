//
//  CuotasPresenterTests.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import XCTest
@testable import MercadoLibreTest

class CuotasPresenterTests: XCTestCase {

    var presenterUnderTest: CuotasPresenter!

    var mockView: CuotasViewControllerMock!
    var mockRouter: CuotasRouterMock!
    var mockRepo: CuotasRepoMock!

    override func setUp() {
        super.setUp()
        mockView = CuotasViewControllerMock()
        mockRouter = CuotasRouterMock()
        mockRepo = CuotasRepoMock()

        presenterUnderTest = CuotasPresenter(view: mockView,
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

    func testGetCuotasFail() {
        presenterUnderTest.getCuotas(successCompletion: { (_) in
        }) { (_) in
        }
        XCTAssertFalse(mockRepo.getCuotasCalled)
    }

    func testGetCuotasSuccess() {
        presenterUnderTest.selectedPaymentMethod = PaymentMethodModel(name: "test",
                                                                      paymentId: "test",
                                                                      secureThumbnail: "test",
                                                                      paymentTypeId: "test",
                                                                      minAllowedAmount: 1,
                                                                      maxAllowedAmount: 50)
        presenterUnderTest.amountEntered = 25
        presenterUnderTest.getCuotas(successCompletion: { (_) in
        }) { (_) in
        }
        XCTAssertTrue(mockRepo.getCuotasCalled)
    }

    func testHandleDidSelectRow() {
        presenterUnderTest.selectedPaymentMethod = PaymentMethodModel(name: "test",
                                                                      paymentId: "test",
                                                                      secureThumbnail: "test",
                                                                      paymentTypeId: "test",
                                                                      minAllowedAmount: 1,
                                                                      maxAllowedAmount: 50)
        presenterUnderTest.cuotasModelArray = [CuotasModel(installments: 1,
                                                           recommendedMessage: "test"),
                                               CuotasModel(installments: 3,
                                                           recommendedMessage: "test")]
        presenterUnderTest.amountEntered = 25
        presenterUnderTest.handleDidSelectRow(indexPathRow: 0)
        XCTAssertNotNil(Notification.init(name: Notification.Name(rawValue: "cuotasFinishedNotification")))
    }

    func testShowErrorAlert() {
        presenterUnderTest.showErrorAlert(error: "test")
        XCTAssertTrue(mockRouter.showErrorAlertCalled)
    }
}
