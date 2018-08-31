//
//  CuotasPresenterMock.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Foundation
@testable import MercadoLibreTest

class CuotasPresenterMock: CuotasPresenterProtocol {

    var cuotasModelArray: [CuotasModel] = [CuotasModel(installments: 1,
                                                       recommendedMessage: "test"),
                                           CuotasModel(installments: 3,
                                                       recommendedMessage: "test")]

    var amountEntered: Int? = 25

    var selectedPaymentMethod: PaymentMethodModel? = PaymentMethodModel(name: "test",
                                                                        paymentId: "test",
                                                                        secureThumbnail: "test",
                                                                        paymentTypeId: "test",
                                                                        minAllowedAmount: 1,
                                                                        maxAllowedAmount: 50)

    var bankSelected: BankSelectModel? = BankSelectModel(name: "test",
                                                         bankId: "test",
                                                         secureThumbnail: "test")

    var getCuotasCalled = false
    func getCuotas(successCompletion: @escaping ([CuotasModel]?) -> Void,
                   failureCompletion: @escaping (String) -> Void) {
        getCuotasCalled = true
        showErrorAlert(error: "test")
    }
    var showErrorAlertCalled = false
    func showErrorAlert(error: String) {
        showErrorAlertCalled = true
    }
    var handleDidSelectRowCalled = false
    func handleDidSelectRow(indexPathRow: Int) {
        handleDidSelectRowCalled = true
    }
}
