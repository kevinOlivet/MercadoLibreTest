//
//  PaymentMethodRouter.swift
//  MercadoLibreTest
//
//  Created by Jon Olivet on 8/29/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import UIKit

protocol PaymentMethodRouterProtocol {
    func showBankSelect(amountEntered: Int,
                        selectedPaymentMethod: PaymentMethodModel)
    func showWrongAmountAlert(name: String,
                              minAmount: Double,
                              maxAmount: Double)
    func showErrorAlert(error: String)
}

class PaymentMethodRouter: PaymentMethodRouterProtocol {

    weak var view: PaymentMethodViewController?

    init(view: PaymentMethodViewController) {
        self.view = view
    }

    func showBankSelect(amountEntered: Int,
                        selectedPaymentMethod: PaymentMethodModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let bankSelectViewController = storyboard.instantiateViewController(withIdentifier: "BankSelectViewController") as! BankSelectViewController
        bankSelectViewController.presenter.amountEntered = amountEntered
        bankSelectViewController.presenter.selectedPaymentMethod = selectedPaymentMethod
        view?.navigationController?.pushViewController(bankSelectViewController, animated: true)
    }

    func showWrongAmountAlert(name: String,
                              minAmount: Double,
                              maxAmount: Double) {
        if let view = view {
            Alerts.dismissableAlert(title: "Choose another".localized(),
                                    message: "\(name) has a minimum amount of \(String(format: "%.2f", minAmount)) and a maximum ammount of \(String(format: "%.2f", maxAmount))".localized(),
                                    vc: view,
                                    actionBtnText: "Ok".localized())
        }
    }

    func showErrorAlert(error: String) {
        if let view = view {
            Alerts.dismissableAlert(title: "Error".localized(),
                                message: error,
                                vc: view,
                                actionBtnText: "Cancel".localized())
        }
    }
}
