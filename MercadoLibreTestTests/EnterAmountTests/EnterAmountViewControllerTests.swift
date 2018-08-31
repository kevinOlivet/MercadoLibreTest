//
//  EnterAmountViewControllerTests.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import XCTest
@testable import MercadoLibreTest

class EnterAmountViewControllerTests: XCTestCase {

    var window: UIWindow!
    var enterAmountViewController: EnterAmountViewController!
    var mockPresenter: EnterAmountPresenterMock!

    override func setUp() {
        super.setUp()
        window = UIWindow()
        enterAmountViewController = UIStoryboard(name: "Main",
                                                 bundle: nil).instantiateViewController(withIdentifier: "EnterAmountViewController") as! EnterAmountViewController
        mockPresenter = EnterAmountPresenterMock()
        enterAmountViewController.presenter = self.mockPresenter
        window.rootViewController = enterAmountViewController
        window.makeKeyAndVisible()
        _ = enterAmountViewController.view
    }

    override func tearDown() {
        mockPresenter = nil
        enterAmountViewController = nil
        self.window = nil
        super.tearDown()
    }

    func testSetUpUI() {
        enterAmountViewController.setUpUI()
        XCTAssertEqual(enterAmountViewController.title, "Amount".localized())
        XCTAssertEqual(enterAmountViewController.enterAmountLabel.text, "Enter amount in Chilean Pesos".localized())
        XCTAssertEqual(enterAmountViewController.nextButton.titleLabel?.text, "Next".localized())
    }

    func testCatchCuota() {
        let notification = Notification(name: Notification.Name(rawValue: "cuotasFinishedNotification"))

        enterAmountViewController.catchCuota(notification: notification)
        XCTAssertTrue(mockPresenter.catchCuotaCalled)
    }

    func testNextButtonTapped() {
        enterAmountViewController.enterAmountTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        enterAmountViewController.enterAmountTextField.text = "50000"
        enterAmountViewController.nextButtonTapped(UIButton())
        XCTAssertTrue(mockPresenter.handleNextButtonTappedCalled)
    }
}
