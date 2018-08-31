//
//  BankSelectRouterTests.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import XCTest
@testable import MercadoLibreTest

class BankSelectRouterTests: XCTestCase {

    var bankSelectRouter: BankSelectRouter!
    var viewController: BankSelectViewController!
    var window: UIWindow!

    override func setUp() {
        super.setUp()
        window = UIWindow()
        viewController = UIStoryboard(name: "Main",
                                      bundle: nil).instantiateViewController(withIdentifier: "BankSelectViewController") as! BankSelectViewController
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        _ = viewController.view
        bankSelectRouter = BankSelectRouter(view: viewController)
    }

    override func tearDown() {
        viewController = nil
        bankSelectRouter = nil
        window = nil
        super.tearDown()
    }

    func testShowCuotas() {
        let paymentMethod = PaymentMethodModel(name: "test",
                                               paymentId: "test",
                                               secureThumbnail: "test",
                                               paymentTypeId: "test",
                                               minAllowedAmount: 1,
                                               maxAllowedAmount: 50)
        let bankSelected = BankSelectModel(name: "test",
                                           bankId: "test",
                                           secureThumbnail: "test")
        bankSelectRouter.showCuotas(amountEntered: 25,
                                   selectedPaymentMethod: paymentMethod,
                                   bankSelected: bankSelected)
        XCTAssertNotNil(CuotasViewController.self)
    }

    func testShowErrorAlert() {
        bankSelectRouter.showErrorAlert(error: "test")
        XCTAssertTrue(viewController.presentedViewController is UIAlertController)
    }
}
