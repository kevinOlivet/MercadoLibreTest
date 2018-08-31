//
//  CuotasViewController.swift
//  MercadoLibreTest
//
//  Created by Jon Olivet on 8/28/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import UIKit

protocol CuotasViewControllerProtocol: class {
    func setUpUI()
}

class CuotasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CuotasViewControllerProtocol {

    @IBOutlet weak var tableView: UITableView!

    lazy var presenter: CuotasPresenterProtocol = {
        let router = CuotasRouter(view: self) as CuotasRouterProtocol
        let repo = Networker() as CuotasRepoProtocol
        return CuotasPresenter(view: self, router: router, repo: repo)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    func setUpUI() {
        let displayName = presenter.bankSelected != nil ? presenter.bankSelected!.name : presenter.selectedPaymentMethod?.name
        self.title = displayName
        let spinner = self.showModalSpinner()
        presenter.getCuotas(successCompletion: { [weak self] (cuotas) in
            self?.hideModalSpinner(indicator: spinner)
            self?.tableView.reloadData()
        }) { [weak self] (error) in
            self?.presenter.showErrorAlert(error: error)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.cuotasModelArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CuotasCell", for: indexPath) as! CuotasTableViewCell
        let cuota = presenter.cuotasModelArray[indexPath.row]
        cell.numberOfInstallmentsLabel.text = "Installments: \(String(cuota.installments))".localized()
        cell.recommendedMessageLabel.text = cuota.recommendedMessage

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.handleDidSelectRow(indexPathRow: indexPath.row)
    }
}
