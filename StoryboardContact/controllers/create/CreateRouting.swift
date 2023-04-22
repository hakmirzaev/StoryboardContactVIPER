//
//  CreateRouting.swift
//  StoryboardContact
//
//  Created by Bekhruz Hakmirzaev on 22/04/23.
//

import Foundation

protocol CreateRoutingProtocol {
    func navigateHomeScreen()
}

class CreateRouting: CreateRoutingProtocol {
    weak var contoller: CreateViewController!
    
    func navigateHomeScreen() {
        contoller.callHomeViewController()
    }
    
}
