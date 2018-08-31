//
//  PaymentMethodViewController.swift
//  MercadoLibreTest
//
//  Created by Jon Olivet on 8/28/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import UIKit

protocol PaymentMethodViewControllerProtocol: class {
    func setUpUI()
}

class PaymentMethodViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PaymentMethodViewControllerProtocol {

    @IBOutlet weak var tableView: UITableView!

    lazy var presenter: PaymentMethodPresenterProtocol = {
        let router = PaymentMethodRouter(view: self) as PaymentMethodRouterProtocol
        let repo = Networker() as PaymentMethodRepoProtocol
        return PaymentMethodPresenter(view: self,
                                      router: router,
                                      repo: repo)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    func setUpUI() {
        if let amountEntered = presenter.amountEntered {
            self.title = "$\(String(amountEntered))"
        }
        let spinner = self.showModalSpinner()
        presenter.getPaymentMethods(successCompletion: { [weak self] (_) in
            self?.hideModalSpinner(indicator: spinner)
            self?.tableView.reloadData()
        }) { [weak self] (error) in
            self?.presenter.showErrorAlert(error: error)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.paymentMethodArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodCell",
                                                 for: indexPath) as! PaymentMethodTableViewCell
        let paymentMethod = presenter.paymentMethodArray[indexPath.row]
        cell.paymentMethodNameLabel.text = paymentMethod.name

        let localUrlString = paymentMethod.secureThumbnail
        presenter.downloadImage(urlString: localUrlString) { (data) in
            cell.paymentImageView.image = UIImage(data: data)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.handleDidSelectRow(indexPathRow: indexPath.row)
    }

}
