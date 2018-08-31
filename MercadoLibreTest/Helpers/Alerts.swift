//
//  Alerts.swift
//  MercadoLibreTest
//
//  Created by Jon Olivet on 8/28/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import UIKit

class Alerts {

    static func dismissableAlert(title: String,
                                 message: String,
                                 vc: UIViewController,
                                 handler: ((UIAlertAction) -> Void)? = { _ in },
                                 actionBtnText: String,
                                 showCancelButton: Bool = false,
                                 cancelHandler: @escaping (UIAlertAction) -> Void = { _ in }) {

        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        if showCancelButton {
            let dismiss = UIAlertAction(title: "Cancel".localized(),
                                        style: .cancel,
                                        handler: cancelHandler)
            alertController.addAction(dismiss)
        }
        let newAction = UIAlertAction(title: actionBtnText,
                                      style: .default,
                                      handler: handler)
        alertController.addAction(newAction)

        vc.present(alertController, animated: true, completion: nil)
    }
}
