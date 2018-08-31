//
//  EnterAmountRouterTests.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import XCTest
@testable import MercadoLibreTest

class EnterAmountRouterTests: XCTestCase {

    var enterAmountRouter: EnterAmountRouter!
    var viewController: EnterAmountViewController!
    var window: UIWindow!

    override func setUp() {
        super.setUp()
        window = UIWindow()
        viewController = UIStoryboard(name: "Main",
                                      bundle: nil).instantiateViewController(withIdentifier: "EnterAmountViewController") as! EnterAmountViewController
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        _ = viewController.view
        enterAmountRouter = EnterAmountRouter(view: viewController)
    }

    override func tearDown() {
        viewController = nil
        enterAmountRouter = nil
        window = nil
        super.tearDown()
    }

    func testShowPaymentMethod() {
        enterAmountRouter.showPaymentMethod(amountEntered: 5000)
        XCTAssertNotNil(PaymentMethodViewController.self)
    }

    func testShowEnterAmountAlert() {
        enterAmountRouter.showEnterAmountAlert()
        XCTAssert(viewController.presentedViewController is UIAlertController)
    }

    func testShowCatchCuotaAlert() {
        enterAmountRouter.showCatchCuotaAlert(finalMessage: "Test")
        XCTAssert(viewController.presentedViewController is UIAlertController)
    }
}
