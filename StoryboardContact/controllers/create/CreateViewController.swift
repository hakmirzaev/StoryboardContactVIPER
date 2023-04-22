//
//  CreateViewController.swift
//  StoryboardContact
//
//  Created by Bekhruz Hakmirzaev on 15/04/23.
//

import UIKit

protocol CreateRequestProtocol {
    func apiContactCreate(contact: Contact)
    
    func navigateHomeScreen()
}

protocol CreateResponseProtocol {
    func onContactCreate(isCreated: Bool)
}


class CreateViewController: BaseViewController, CreateResponseProtocol {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var phoneLabel: UITextField!
    var presenter: CreateRequestProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        configureViper()
    }
    
    func onContactCreate(isCreated: Bool) {
        if isCreated {
            self.navigationController?.popViewController(animated: true)
        } else {
            // Error
            print("Error")
        }
    }

    func initView() {
        title = "Create Contact"
    }
    
    func callHomeViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func configureViper(){
        let manager = HttpManager()
        let presenter = CreatePresenter()
        let interactor = CreateInteractor()
        let routing = CreateRouting()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.interactor = interactor
        presenter.routing = routing
        routing.contoller = self
        interactor.manager = manager
        interactor.response = self
    }
    
    @IBAction func createButton(_ sender: Any) {
        if nameLabel.text != nil && phoneLabel.text != nil {
            self.presenter.apiContactCreate(contact: Contact(name: nameLabel.text!, phone: phoneLabel.text!))
        }
    }
    

}
