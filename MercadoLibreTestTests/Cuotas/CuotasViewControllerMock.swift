//
//  CuotasViewControllerMock.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Foundation
@testable import MercadoLibreTest

class CuotasViewControllerMock: CuotasViewControllerProtocol {
    var setUpUICalled = false
    func setUpUI() {
        setUpUICalled = true
    }
}
