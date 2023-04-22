//
//  HomeViewController.swift
//  StoryboardContact
//
//  Created by Bekhruz Hakmirzaev on 15/04/23.
//

import UIKit

protocol HomeRequestProtocol {
    func apiContactList()
    func apiContactDelete(contact: Contact)
    
    func navigateCreateScreen()
    func navigateEditScreen(contact: Contact)
}

protocol HomeResponseProtocol {
    func onContactList(contacts: [Contact])
    func onContactDelete(isDeleted: Bool)
}


class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, HomeResponseProtocol {

    @IBOutlet weak var tableView: UITableView!
    var items = Array<Contact>()
    var presenter: HomeRequestProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    func refreshTableView(contacts: [Contact]) {
        self.items = contacts
        self.tableView.reloadData()
    }
    
    func onContactList(contacts: [Contact]) {
        self.hideProgress()
        self.refreshTableView(contacts: contacts)
    }
    
    func onContactDelete(isDeleted: Bool) {
        self.hideProgress()
        presenter.apiContactList()
    }
    
    

    // MARK: - Method
    
    func initViews() {
        tableView.dataSource = self
        tableView.delegate = self
        
        initNavigation()
        configureViper()
        
        presenter.apiContactList()
    }
    
    func configureViper(){
        let manager = HttpManager()
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let routing = HomeRouting()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.interactor = interactor
        presenter.routing = routing
        routing.contoller = self
        interactor.manager = manager
        interactor.response = self
    }
    
    func initNavigation() {
        let refresh = UIImage(named: "ic_refresh")
        let add = UIImage(named: "ic_add")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Storyboard Contact"
    }
    
    func callCreateViewController() {
        let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callEditViewController(contact: Contact) {
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        vc.contact = contact
        let nc = UINavigationController(rootViewController: vc)
        self.present(nc, animated: true)
    }

    // MARK: - Action
    
    @objc func leftTapped() {
        presenter.apiContactList()
    }
    
    @objc func rightTapped() {
        callCreateViewController()
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("ContactTableViewCell", owner: self, options: nil)?.first as! ContactTableViewCell
        
        cell.nameLabel.text = item.name
        cell.phoneLabel.text = item.phone
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        return UISwipeActionsConfiguration(actions: [makeCompleteContextualAction(forRowAt: indexPath, contact: items[indexPath.row])])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [makeDeleteContextualAction(forRowAt: indexPath, contact: items[indexPath.row])])
    }
    
    // MARK: - Contextual Actions
    
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath, contact: Contact) -> UIContextualAction{
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            print("DELETE HERE")
            
            self.presenter.apiContactDelete(contact: contact)
            completion(true)
        }
    }
    
    private func makeCompleteContextualAction(forRowAt indexPath: IndexPath, contact: Contact) -> UIContextualAction{
        return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
            print("COMPLETE HERE")
            self.callEditViewController(contact: contact)
            completion(true)
        }
    }
}
