//
//  EditViewController.swift
//  StoryboardContact
//
//  Created by Bekhruz Hakmirzaev on 15/04/23.
//

import UIKit

protocol EditRequestProtocol {
    func apiContactEdit(contact: Contact)
    
    func navigateHomeScreen()
}

protocol EditResponseProtocol {
    func onContactEdit(isEdited: Bool)
}


class EditViewController: BaseViewController, EditResponseProtocol {

    var contact: Contact = Contact(name: "", phone: "")
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var phoneLabel: UITextField!
    var presenter: EditRequestProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        configureViper()
    }
    
    func onContactEdit(isEdited: Bool) {
        if isEdited {
            self.hideProgress()
            self.dismiss(animated: true, completion: nil)
        } else {
            // Error
            print("Error")
        }
    }
    
    func initView() {
        nameLabel.text = contact.name!
        phoneLabel.text = contact.phone!
        
        title = "Edit Contact"
    }
    
    func callHomeViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureViper(){
        let manager = HttpManager()
        let presenter = EditPresenter()
        let interactor = EditInteractor()
        let routing = EditRouting()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.interactor = interactor
        presenter.routing = routing
        routing.contoller = self
        interactor.manager = manager
        interactor.response = self
    }

    @IBAction func saveButton(_ sender: Any) {
        if nameLabel.text != nil && phoneLabel.text != nil {
            self.presenter.apiContactEdit(contact: Contact(id: contact.id!, name: nameLabel.text!, phone: phoneLabel.text!))
        }
    }
    

}
