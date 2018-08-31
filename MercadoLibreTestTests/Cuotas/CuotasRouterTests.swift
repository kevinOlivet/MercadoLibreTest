//
//  CuotasRouterTests.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import XCTest
@testable import MercadoLibreTest

class CuotasRouterTests: XCTestCase {

    var cuotasRouter: CuotasRouter!
    var viewController: CuotasViewController!
    var window: UIWindow!

    override func setUp() {
        super.setUp()
        window = UIWindow()
        viewController = UIStoryboard(name: "Main",
                                      bundle: nil).instantiateViewController(withIdentifier: "CuotasViewController") as! CuotasViewController
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        _ = viewController.view
        cuotasRouter = CuotasRouter(view: viewController)
    }

    override func tearDown() {
        viewController = nil
        cuotasRouter = nil
        window = nil
        super.tearDown()
    }

    func testShowErrorAlert() {
        cuotasRouter.showErrorAlert(error: "test")
        XCTAssertTrue(viewController.presentedViewController is UIAlertController)
    }
}
