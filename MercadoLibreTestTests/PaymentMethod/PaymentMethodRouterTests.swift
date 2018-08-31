//
//  PaymentMethodRouterTests.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import XCTest
@testable import MercadoLibreTest

class PaymentMethodRouterTests: XCTestCase {
    
    var paymentMethodRouter: PaymentMethodRouter!
    var viewController: PaymentMethodViewController!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PaymentMethodViewController") as! PaymentMethodViewController
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        _ = viewController.view
        paymentMethodRouter = PaymentMethodRouter(view: viewController)
    }

    override func tearDown() {
        viewController = nil
        paymentMethodRouter = nil
        window = nil
        super.tearDown()
    }

    func testShowBankSelect() {
        let paymentMethod = PaymentMethodModel(name: "test",
                                               paymentId: "test",
                                               secureThumbnail: "test",
                                               paymentTypeId: "test",
                                               minAllowedAmount: 1,
                                               maxAllowedAmount: 50)
        paymentMethodRouter.showBankSelect(amountEntered: 50, selectedPaymentMethod: paymentMethod)
        XCTAssertNotNil(BankSelectViewController.self)
    }

    func testShowWrongAmountAlert() {
        paymentMethodRouter.showWrongAmountAlert(name: "test", minAmount: 1, maxAmount: 50)
        XCTAssertTrue(viewController.presentedViewController is UIAlertController)
    }

    func testshowErrorAlert() {
        paymentMethodRouter.showErrorAlert(error: "test")
        XCTAssertTrue(viewController.presentedViewController is UIAlertController)
    }
}
