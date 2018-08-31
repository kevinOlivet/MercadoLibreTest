//
//  PaymentMethodPresenterMock.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Foundation
@testable import MercadoLibreTest

class PaymentMethodPresenterMock: PaymentMethodPresenterProtocol {

    var paymentMethodArray = [PaymentMethodModel]()
    var amountEntered: Int?

    var getPaymentMethodsCalled = false
    func getPaymentMethods(successCompletion: @escaping ([PaymentMethodModel]?) -> Void,
                           failureCompletion: @escaping (String) -> Void) {
        getPaymentMethodsCalled = true
        showErrorAlert(error: "test")
    }
    var downloadImageCalled = false
    func downloadImage(urlString: String, completion: @escaping (Data) -> Void) {
        downloadImageCalled = true
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
