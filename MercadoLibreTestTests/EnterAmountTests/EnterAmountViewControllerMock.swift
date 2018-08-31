//
//  EnterAmountViewControllerMock.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Foundation
@testable import MercadoLibreTest

class EnterAmountViewControllerMock: EnterAmountViewControllerProtocol {
    var setUpUICalled = false
    func setUpUI() {
        setUpUICalled = true
    }
    var catchCuotaCalled = false
    func catchCuota(notification: Notification) {
        catchCuotaCalled = true
    }
    var nextButtonTappedCalled = false
    func nextButtonTapped(_ sender: Any) {
        nextButtonTappedCalled = true
    }
}
