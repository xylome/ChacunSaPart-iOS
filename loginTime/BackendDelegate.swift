//
//  BackendDelegate.swift
//  loginTime
//
//  Created by Xavier Heroult on 05/04/2016.
//  Copyright © 2016 Xavier Heroult. All rights reserved.
//

import Foundation

protocol BackendDelegate {
    func onResult(result: LoginResponse)
    func onError(result: String)
}