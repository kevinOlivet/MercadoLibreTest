//
//  EnterAmountPresenter.swift
//  MercadoLibreTest
//
//  Created by Jon Olivet on 8/29/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Foundation

protocol EnterAmountPresenterProtocol {
    func handleNextButtonTapped(amountEntered: String)
    func catchCuota(notification: Notification)
    var amountEntered: Int? { get set }
}

class EnterAmountPresenter: EnterAmountPresenterProtocol {

    var amountEntered: Int?

    weak var view: EnterAmountViewControllerProtocol?
    var router: EnterAmountRouterProtocol

    init(view: EnterAmountViewControllerProtocol, router: EnterAmountRouterProtocol) {
        self.view = view
        self.router = router
    }

    func handleNextButtonTapped(amountEntered: String) {
        if !amountEntered.isEmpty {
            let validator = NumericValidation.sharedInstance
            if validator.validateString(str: amountEntered) {
                if let amountEntered = Int(amountEntered) {
                    router.showPaymentMethod(amountEntered: amountEntered)
                }
            } else {
                let numberToUse = validator.getMatchingString(str: amountEntered)
                view?.setTextFieldWithRegexNumber(numberToUse: numberToUse!)
                print("Here: ", numberToUse!)
                router.showNumberToUseAlert(message: validator.validationMessage)
            }
        } else {
            router.showEnterAmountAlert()
        }
    }

    func catchCuota(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let finalMessage = userInfo["finalMessage"] as? String else { return }
        router.showCatchCuotaAlert(finalMessage: finalMessage)
    }
}
