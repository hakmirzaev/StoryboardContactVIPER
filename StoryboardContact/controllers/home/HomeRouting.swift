//
//  HomeRouting.swift
//  StoryboardContact
//
//  Created by Bekhruz Hakmirzaev on 22/04/23.
//

import Foundation

protocol HomeRoutingProtocol {
    func navigateCreateScreen()
    func navigateEditScreen()
}

class HomeRouting: HomeRoutingProtocol {
    weak var contoller: HomeViewController!
    
    func navigateCreateScreen() {
        contoller.callCreateViewController()
    }
    
    func navigateEditScreen() {
        contoller.callEditViewController(contact: Contact(name: "", phone: ""))
    }
    
    
}
