//
//  PaymentMethodRouterMock.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Foundation
@testable import MercadoLibreTest

class PaymentMethodRouterMock: PaymentMethodRouterProtocol {
    var showBankSelectCalled = false
    func showBankSelect(amountEntered: Int,
                        selectedPaymentMethod: PaymentMethodModel) {
        showBankSelectCalled = true
    }
    var showWrongAmountAlertCalled = false
    func showWrongAmountAlert(name: String,
                              minAmount: Double,
                              maxAmount: Double) {
        showBankSelectCalled = true
    }
    var showErrorAlertCalled = false
    func showErrorAlert(error: String) {
        showBankSelectCalled = true
    }
}
