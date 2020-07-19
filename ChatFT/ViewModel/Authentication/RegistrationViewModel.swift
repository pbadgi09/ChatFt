//
//  RegistrationViewModel.swift
//  ChatFT
//
//  Created by Pranav Badgi on 11/04/20.
//  Copyright © 2020 Pranav Badgi. All rights reserved.
//

import Foundation


struct RegistrationViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
            && fullname?.isEmpty == false
            && username?.isEmpty == false
    }
}
