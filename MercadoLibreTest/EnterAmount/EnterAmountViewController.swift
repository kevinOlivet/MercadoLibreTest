//
//  EnterAmountViewController.swift
//  MercadoLibreTest
//
//  Created by Jon Olivet on 8/28/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import UIKit

protocol EnterAmountViewControllerProtocol: class {
    func setUpUI()
    func catchCuota(notification: Notification)
    func setTextFieldWithRegexNumber(numberToUse: String)
    func nextButtonTapped(_ sender: Any)
}

class EnterAmountViewController: UIViewController, EnterAmountViewControllerProtocol {

    @IBOutlet weak var enterAmountTextField: UITextField!
    @IBOutlet weak var enterAmountLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!

    lazy var presenter: EnterAmountPresenterProtocol = {
        let router = EnterAmountRouter(view: self) as EnterAmountRouterProtocol
        return EnterAmountPresenter(view: self, router: router)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    func setUpUI() {
        self.title = "Amount".localized()
        enterAmountLabel.text = "Enter amount in Chilean Pesos".localized()
        nextButton.titleLabel?.text = "Next".localized()

        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "cuotasFinishedNotification"), object: nil, queue: nil, using: catchCuota)
    }

    func catchCuota(notification: Notification) {
        presenter.catchCuota(notification: notification)
    }
    
    func setTextFieldWithRegexNumber(numberToUse: String) {
        enterAmountTextField.text = numberToUse
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let amountEntered = enterAmountTextField.text else  { return }
            presenter.handleNextButtonTapped(amountEntered: amountEntered)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
