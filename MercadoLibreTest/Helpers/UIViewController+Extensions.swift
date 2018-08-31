//
//  UIViewController+Extensions.swift
//  MercadoLibreTest
//
//  Created by Jon Olivet on 8/29/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import UIKit

extension UIViewController{

    func showModalSpinner() -> UIActivityIndicatorView {
        
        // User cannot interact with the app while the spinner is visible
        UIApplication.shared.beginIgnoringInteractionEvents()

        var indicator = UIActivityIndicatorView()

        indicator = UIActivityIndicatorView(frame: self.view.frame)
        indicator.center = self.view.center
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        indicator.color = UIColor.black
        indicator.hidesWhenStopped = true
        indicator.startAnimating()

        self.view.addSubview(indicator)

        return indicator
    }

    // Hides the loading indicator and enables user interaction with the app
    func hideModalSpinner(indicator: UIActivityIndicatorView){

        indicator.stopAnimating()
        indicator.isHidden = true

        // user can interact again with the app
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
