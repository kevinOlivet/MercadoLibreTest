//
//  EnterAmountPresenterTests.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import XCTest
@testable import MercadoLibreTest

class EnterAmountPresenterTests: XCTestCase {

    var presenterUnderTest: EnterAmountPresenter!

    var mockView: EnterAmountViewControllerMock!
    var mockRouter: EnterAmountRouterMock!

    override func setUp() {
        super.setUp()
        mockView = EnterAmountViewControllerMock()
        mockRouter = EnterAmountRouterMock()
        presenterUnderTest = EnterAmountPresenter(view: mockView,
                                                  router: mockRouter)
    }

    override func tearDown() {
        mockView = nil
        mockRouter = nil
        presenterUnderTest = nil
        super.tearDown()
    }

    func testHandleNextButtonTappedSuccess() {
        presenterUnderTest.handleNextButtonTapped(amountEntered: "500")
        XCTAssertTrue(mockRouter.showPaymentMethodCalled)
    }
    func testHandleNextButtonTappedFail() {
        var amount = ""
        amount.removeAll()
        presenterUnderTest.handleNextButtonTapped(amountEntered: amount)
        XCTAssertFalse(mockRouter.showEnterAmountAlertCalled)
    }
    func testCatchCuota() {
        let notificationName = Notification.Name(rawValue: "cuotasFinishedNotification")

        let myNotification = Notification(name: notificationName,
                                          object: nil,
                                          userInfo: ["finalMessage": "Test"])
        presenterUnderTest.catchCuota(notification: myNotification)

        XCTAssertTrue(mockRouter.showCatchCuotaAlertCalled)
    }
    func testNotifications() {
        var finalMessage: String?
        let notificationName = Notification.Name(rawValue: "cuotasFinishedNotification")

        expectation(forNotification: notificationName,
                    object: nil,
                    handler: nil)
        let handler = { (notification: Notification) -> Bool in
            if let message = notification.userInfo?["finalMessage"] as? String {
                finalMessage = message
            }
            return true
        }
        expectation(forNotification: notificationName,
                    object: nil,
                    handler: handler)

        let operation = BlockOperation(block: {
            NotificationCenter.default.post(name: notificationName,
                                            object: nil,
                                            userInfo: ["finalMessage": "TestMesage"])
        })
        operation.start()
        waitForExpectations(timeout: 3, handler: nil)

        XCTAssertNotNil(finalMessage)
        XCTAssertEqual(finalMessage, "TestMesage")
    }
}
