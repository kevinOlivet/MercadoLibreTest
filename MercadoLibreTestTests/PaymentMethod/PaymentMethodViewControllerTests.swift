//
//  PaymentMethodViewControllerTests.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import XCTest
@testable import MercadoLibreTest

class PaymentMethodViewControllerTests: XCTestCase {

    var window: UIWindow!
    var paymentMethodViewController: PaymentMethodViewController!
    var mockPresenter: PaymentMethodPresenterMock!

    override func setUp() {
        super.setUp()
        window = UIWindow()
        mockPresenter = PaymentMethodPresenterMock()
        mockPresenter.amountEntered = 500

        paymentMethodViewController = UIStoryboard(name: "Main",
                                                   bundle: nil).instantiateViewController(withIdentifier: "PaymentMethodViewController") as! PaymentMethodViewController
        paymentMethodViewController.presenter = self.mockPresenter

        window.rootViewController = paymentMethodViewController
        window.makeKeyAndVisible()
        _ = paymentMethodViewController.view
        
    }

    override func tearDown() {
        mockPresenter = nil
        paymentMethodViewController = nil
        self.window = nil
        super.tearDown()
    }

    func testSetUpUI() {
        paymentMethodViewController.setUpUI()
        XCTAssertEqual(paymentMethodViewController.title, "$500")
        XCTAssertTrue(mockPresenter.getPaymentMethodsCalled)
        XCTAssertTrue(mockPresenter.showErrorAlertCalled)
        XCTAssertFalse(mockPresenter.downloadImageCalled)
    }

    func testViewDidLoad() {
        XCTAssertEqual(paymentMethodViewController.title, "$500")
        XCTAssertTrue(mockPresenter.getPaymentMethodsCalled)
        XCTAssertTrue(mockPresenter.showErrorAlertCalled)
        XCTAssertFalse(mockPresenter.downloadImageCalled)
    }

    func testPaymentMethodArrayEmpty() {
        XCTAssertEqual(paymentMethodViewController.tableView.numberOfRows(inSection: 0), 0)
    }

    func testViewpaymentMethodArrayNotEmpty() {
        mockPresenter.paymentMethodArray = [PaymentMethodModel(name: "test",
                                                               paymentId: "test",
                                                               secureThumbnail: "test",
                                                               paymentTypeId: "test",
                                                               minAllowedAmount: 1,
                                                               maxAllowedAmount: 50)]
        paymentMethodViewController.tableView.reloadData()
        XCTAssertEqual(paymentMethodViewController.tableView.numberOfRows(inSection: 0), 1)
    }
    func testDidSelect() {
        mockPresenter.paymentMethodArray = [PaymentMethodModel(name: "test",
                                                               paymentId: "test",
                                                               secureThumbnail: "test",
                                                               paymentTypeId: "test",
                                                               minAllowedAmount: 1,
                                                               maxAllowedAmount: 50)]
        paymentMethodViewController.tableView.reloadData()
        paymentMethodViewController.tableView(paymentMethodViewController.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockPresenter.handleDidSelectRowCalled)
    }
}
