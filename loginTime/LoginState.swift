//
//  LoginState.swift
//  loginTime
//
//  Created by Xavier Heroult on 08/04/2016.
//  Copyright © 2016 Xavier Heroult. All rights reserved.
//

import Foundation

class LoginState: NSObject {
    
    static var sharedIntance = LoginState()
    dynamic var logged = "not Logged"
    var loginResponse: LoginResponse?
    
    private override init() {
        super.init()
    }
    
    func updateLogged(state: String) {
        print("changing state from \(logged) to \(state)")
        logged = state
    }
}