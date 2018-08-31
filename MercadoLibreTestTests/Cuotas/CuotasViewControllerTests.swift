//
//  CuotasViewControllerTests.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import XCTest
@testable import MercadoLibreTest

class CuotasViewControllerTests: XCTestCase {

    var window: UIWindow!
    var cuotasViewController: CuotasViewController!
    var mockPresenter: CuotasPresenterMock!

    override func setUp() {
        super.setUp()
        window = UIWindow()
        mockPresenter = CuotasPresenterMock()

        cuotasViewController = UIStoryboard(name: "Main",
                                            bundle: nil).instantiateViewController(withIdentifier: "CuotasViewController") as! CuotasViewController
        cuotasViewController.presenter = self.mockPresenter

        window.rootViewController = cuotasViewController
        window.makeKeyAndVisible()
        _ = cuotasViewController.view
    }

    override func tearDown() {
        mockPresenter = nil
        cuotasViewController = nil
        self.window = nil
        super.tearDown()
    }

    func testSetUpUI() {
        cuotasViewController.setUpUI()
        XCTAssertEqual(cuotasViewController.title, "test")
        XCTAssertTrue(mockPresenter.getCuotasCalled)
        XCTAssertTrue(mockPresenter.showErrorAlertCalled)
    }

    func testViewDidLoad() {
        XCTAssertEqual(cuotasViewController.title, "test")
        XCTAssertTrue(mockPresenter.getCuotasCalled)
        XCTAssertTrue(mockPresenter.showErrorAlertCalled)
    }

    func testCuotasModelArrayNotEmpty() {
        XCTAssertEqual(cuotasViewController.tableView(cuotasViewController.tableView, numberOfRowsInSection: 0), 2)
    }

    func testCuotasModelArrayEmpty() {
        mockPresenter.cuotasModelArray.removeAll()
        cuotasViewController.tableView.reloadData()
        XCTAssertEqual(cuotasViewController.tableView(cuotasViewController.tableView, numberOfRowsInSection: 0), 0)
    }

    func testDidSelect() {
        cuotasViewController.tableView(cuotasViewController.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockPresenter.handleDidSelectRowCalled)
    }
}
