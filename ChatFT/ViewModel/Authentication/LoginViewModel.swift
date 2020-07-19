//
//  LoginViewModel.swift
//  ChatFT
//
//  Created by Pranav Badgi on 11/04/20.
//  Copyright © 2020 Pranav Badgi. All rights reserved.
//

import Foundation

//agar aisa situation hai ke same type ka model bhaut jagah use ho raha hai
//like login and auth tab protocol use karna accha reheta hai
//this will work in regist. by using just ":AuthenticationProtocol"

protocol  AuthenticationProtocol  {
    var formIsValid: Bool { get }
}

struct LoginViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
    }
}
