//
//  VariationsViewController.swift
//  Acronym And Meanings
//
//  Created by Fridous hussain on 13/02/22.
//

import Foundation
import UIKit

class VariationsViewController: UIViewController {
    @IBOutlet weak var variationsTableView: UITableView!
    @IBOutlet weak var noResultsLabel: UILabel!
    private var viewModel: VariationsViewModel!
    var meaning: Meaning!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let meaning = meaning {
            self.viewModel = VariationsViewModel.init(meaning: meaning)
        } else {
            self.viewModel = VariationsViewModel(meaning: Meaning())
        }
        self.setupUI()
    }
    
    func setupUI() {
        if self.viewModel?.variations.count ?? 0 > 0 {
            self.variationsTableView.isHidden = false
            self.noResultsLabel.isHidden = true
        } else {
            self.noResultsLabel.isHidden = false
            self.variationsTableView.isHidden = true
            self.noResultsLabel.text = viewModel.noResultsText
        }
    }
}

extension VariationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.variations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reUseID = "VariationsCellIdentifier"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reUseID) else {
            return UITableViewCell()
        }
        let variation = self.viewModel.variations[indexPath.row]
        cell.textLabel?.text = variation.meaning
        cell.detailTextLabel?.text = variation.detailText
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

