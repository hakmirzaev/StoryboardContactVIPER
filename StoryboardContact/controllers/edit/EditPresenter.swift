//
//  EditPresenter.swift
//  StoryboardContact
//
//  Created by Bekhruz Hakmirzaev on 22/04/23.
//

import Foundation

protocol EditPresenterProtocol: EditRequestProtocol {
    func apiContactEdit(contact: Contact)
    
    func navigateHomeScreen()
}

class EditPresenter: EditPresenterProtocol {
    
    var interactor: EditInteractorProtocol!
    var routing: EditRoutingProtocol!
    
    var controller: BaseViewController!
    
    func apiContactEdit(contact: Contact) {
        controller.showProgress()
        interactor.apiContactEdit(contact: contact)
    }
    
    func navigateHomeScreen() {
        routing.navigateHomeScreen()
    }
}
