//
//  EditInteractor.swift
//  StoryboardContact
//
//  Created by Bekhruz Hakmirzaev on 22/04/23.
//

import Foundation

protocol EditInteractorProtocol {
    func apiContactEdit(contact: Contact)
}

class EditInteractor: EditInteractorProtocol {
    var manager: HttpManagerProtocol!
    var response: EditResponseProtocol!
    
    func apiContactEdit(contact: Contact) {
        manager.apiContactEdit(contact: contact, completion: { (result) in
            self.response.onContactEdit(isEdited: result)
        })
    }
    
}
