//
//  HomeViewController.swift
//  Acronym And Meanings
//
//  Created by Fridous hussain on 12/02/22.
//

import Foundation
import UIKit
import MBProgressHUD

class HomeViewController: UIViewController {
    
    @IBOutlet weak var meaningsTableView: UITableView!
    @IBOutlet weak var acronymSearchBar: UISearchBar!
    private var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        viewModel = HomeViewModel()
        self.resetContent()
    }
    
    func resetContent() {
        self.meaningsTableView.isHidden = true
        self.viewModel.acronym = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "VariationsIdentifier" {
            if  let indexPath = self.meaningsTableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as?  VariationsViewController {
                let meaning = self.viewModel.acronym?.meanings[indexPath.row]
                destinationVC.meaning = meaning;
            }
        }
    }
    
    func showErrorAert(title: String, message: String) {
        let alertController: UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func fetchMeanings() {
        if let searchText = acronymSearchBar.text, !(acronymSearchBar.text?.isEmpty ?? false) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            viewModel.fetchMeaningsForAcronym(acronym: searchText) { success, error in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                if success {
                    if self.viewModel.acronym?.meanings.count ?? 0 > 0 {
                        self.meaningsTableView.isHidden = false
                        self.meaningsTableView.reloadData()
                    } else {
                        self.showErrorAert(title: NSLocalizedString("NoResultsTitle", comment: ""), message: String(format: NSLocalizedString("NoResultsMessage", comment: ""), self.acronymSearchBar.text!))
                    }
                } else {
                    self.showErrorAert(title: "No Results", message: error?.localizedDescription ?? "")
                }
            }
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.resetContent()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if !(searchBar.text?.isEmpty ?? false) {
            self.fetchMeanings()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.acronym?.meanings.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reUseId = "CellIdentifier"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reUseId)
        
        let meaning = self.viewModel.acronym?.meanings[indexPath.row]
        
        cell?.textLabel?.text = meaning?.meaning
        cell?.detailTextLabel?.text = meaning?.detailText
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}



