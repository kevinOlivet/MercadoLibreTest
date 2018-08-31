//
//  BankSelectViewControllerTests.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import XCTest
@testable import MercadoLibreTest

class BankSelectViewControllerTests: XCTestCase {

    var window: UIWindow!
    var bankSelectViewController: BankSelectViewController!
    var mockPresenter: BankSelectPresenterMock!

    override func setUp() {
        super.setUp()
        window = UIWindow()
        mockPresenter = BankSelectPresenterMock()

        bankSelectViewController = UIStoryboard(name: "Main",
                                                bundle: nil).instantiateViewController(withIdentifier: "BankSelectViewController") as! BankSelectViewController
        bankSelectViewController.presenter = self.mockPresenter

        window.rootViewController = bankSelectViewController
        window.makeKeyAndVisible()
        _ = bankSelectViewController.view
    }

    override func tearDown() {
        mockPresenter = nil
        bankSelectViewController = nil
        self.window = nil
        super.tearDown()
    }

    func testSetUpUI() {
        XCTAssertEqual(bankSelectViewController.title, "test")
        XCTAssertTrue(mockPresenter.getBankSelectCalled)
        XCTAssertTrue(mockPresenter.showErrorAlertCalled)
        XCTAssertFalse(mockPresenter.downloadImageCalled)
    }

    func testViewDidLoad() {
        XCTAssertEqual(bankSelectViewController.title, "test")
        XCTAssertTrue(mockPresenter.getBankSelectCalled)
        XCTAssertTrue(mockPresenter.showErrorAlertCalled)
        XCTAssertFalse(mockPresenter.downloadImageCalled)
    }

    func testViewBankSelectModelArrayNotEmpty() {
        XCTAssertEqual(bankSelectViewController.collectionView.numberOfItems(inSection: 0), 2)
    }

    func testBankSelectModelArrayEmpty() {
        mockPresenter.bankSelectModelArray.removeAll()
        bankSelectViewController.collectionView.reloadData()
        XCTAssertEqual(bankSelectViewController.collectionView.numberOfItems(inSection: 0), 1)
    }

    func testDidSelect() {
        bankSelectViewController.collectionView(bankSelectViewController.collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(mockPresenter.handleDidSelectItemCalled)
    }
}
