//
//  CreatePresenter.swift
//  StoryboardContact
//
//  Created by Bekhruz Hakmirzaev on 22/04/23.
//

import Foundation

protocol CreatePresenterProtocol: CreateRequestProtocol {
    func apiContactCreate(contact: Contact)
    
    func navigateHomeScreen()
}

class CreatePresenter: CreatePresenterProtocol {
    
    var interactor: CreateInteractorProtocol!
    var routing: CreateRoutingProtocol!
    
    var controller: BaseViewController!
    
    func apiContactCreate(contact: Contact) {
        controller.showProgress()
        interactor.apiContactCreate(contact: contact)
    }
    
    func navigateHomeScreen() {
        routing.navigateHomeScreen()
    }
}
