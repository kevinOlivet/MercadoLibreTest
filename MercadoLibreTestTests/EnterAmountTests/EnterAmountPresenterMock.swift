//
//  EnterAmountPresenterMock.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Foundation
@testable import MercadoLibreTest

class EnterAmountPresenterMock: EnterAmountPresenterProtocol {

    var amountEntered: Int?

    var handleNextButtonTappedCalled = false
    func handleNextButtonTapped(amountEntered: String) {
        handleNextButtonTappedCalled = true
    }
    var catchCuotaCalled = false
    func catchCuota(notification: Notification) {
        catchCuotaCalled = true
    }
}
