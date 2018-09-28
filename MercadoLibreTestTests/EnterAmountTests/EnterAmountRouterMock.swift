//
//  EnterAmountRouterMock.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Foundation
@testable import MercadoLibreTest

class EnterAmountRouterMock: EnterAmountRouterProtocol {
    var showPaymentMethodCalled = false
    func showPaymentMethod(amountEntered: Int) {
        showPaymentMethodCalled = true
    }
    var showEnterAmountAlertCalled = false
    func showEnterAmountAlert() {
        showPaymentMethodCalled = true
    }
    var showCatchCuotaAlertCalled = false
    func showCatchCuotaAlert(finalMessage: String) {
        showCatchCuotaAlertCalled = true
    }
    var showNumberToUseAlertCalled = false
    func showNumberToUseAlert(message: String) {
        showNumberToUseAlertCalled = true
    }
}
