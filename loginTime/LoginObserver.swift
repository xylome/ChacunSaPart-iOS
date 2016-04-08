//
//  LoginObserver.swift
//  loginTime
//
//  Created by Xavier Heroult on 08/04/2016.
//  Copyright © 2016 Xavier Heroult. All rights reserved.
//

import Foundation

class LoginObserver: NSObject {
    var loginState = LoginState.sharedIntance
    var mycontext = 1
    override init() {
        super.init()
        //loginState.addObserver(self, forKeyPath: "loginState", options: .New, context: 1)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &mycontext {
            if let newValue = change?[NSKeyValueChangeNewKey] {
                print("New value for login state \(newValue)")
            }
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    deinit {
        loginState.removeObserver(self, forKeyPath: "loginState", context: &mycontext)
    }
}