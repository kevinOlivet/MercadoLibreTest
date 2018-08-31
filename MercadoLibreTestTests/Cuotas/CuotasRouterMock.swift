//
//  CuotasRouterMock.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Foundation
@testable import MercadoLibreTest

class CuotasRouterMock: CuotasRouterProtocol {
    var showErrorAlertCalled = false
    func showErrorAlert(error: String) {
        showErrorAlertCalled = true
    }
}
