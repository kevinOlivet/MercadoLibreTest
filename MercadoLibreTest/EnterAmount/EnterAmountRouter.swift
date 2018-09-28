//
//  EnterAmountRouter.swift
//  MercadoLibreTest
//
//  Created by Jon Olivet on 8/29/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import UIKit

protocol EnterAmountRouterProtocol {
    func showPaymentMethod(amountEntered: Int)
    func showEnterAmountAlert()
    func showCatchCuotaAlert(finalMessage: String)
    func showNumberToUseAlert(message: String)
}

class EnterAmountRouter: EnterAmountRouterProtocol {

    weak var view: EnterAmountViewController?

    init(view: EnterAmountViewController) {
        self.view = view
    }

    func showPaymentMethod(amountEntered: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let paymentMethodViewController = storyboard.instantiateViewController(withIdentifier: "PaymentMethodViewController") as! PaymentMethodViewController
        paymentMethodViewController.presenter.amountEntered = amountEntered
        view?.navigationController?.pushViewController(paymentMethodViewController,
                                                       animated: true)
    }

    func showEnterAmountAlert() {
        if let view = view {
            Alerts.dismissableAlert(title: "Enter amount".localized(),
                                    message: "You need to enter an amount".localized(),
                                    vc: view,
                                    actionBtnText: "Ok".localized())
        }
    }

    func showCatchCuotaAlert(finalMessage: String) {
        if let view = view {
            view.navigationController?.popToRootViewController(animated: true)
            Alerts.dismissableAlert(title: "Finished".localized(),
                                    message: finalMessage,
                                    vc: view,
                                    actionBtnText: "Ok".localized())
        }
    }
    
    func showNumberToUseAlert(message: String) {
        if let view = view {
        Alerts.dismissableAlert(title: "Invalid number".localized(),
                                message: message,
                                vc: view,
                                actionBtnText: "Ok".localized())
        }
    }
}
