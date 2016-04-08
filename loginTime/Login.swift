//
//  File.swift
//  loginTime
//
//  Created by Xavier Heroult on 05/04/2016.
//  Copyright © 2016 Xavier Heroult. All rights reserved.
//

import UIKit

class Login {
    let server = "https://www.chacunsapart.com/"
    let api = "json.php"
    
    var login: String = ""
    var password: String = ""
    var cookie: String = ""
    var accountId: String? = ""
    var nick: String? = ""
    var actorId: String? = ""
    var email: String? = ""
    var authCookie: String? = ""
    
    var delegate: BackendDelegate?
    
    init(login: String, password: String, delegate: BackendDelegate) {
        self.login = login
        self.password = password
        self.delegate = delegate
    }
    
    func log() {
        var loginUrl = server + api
        loginUrl += "?action=login"
        loginUrl += "&params={\"email\":\"" + login + "\",\"password\":\"" + password + "\"}"
        dataRequest(loginUrl)
    }
    
    
    func dataRequest(myUrl: String)
    {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        //let session = NSURLSession.sharedSession()
        if let encodedString = myUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet()), url = NSURL(string: encodedString) {
            
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "GET"
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            print("Will send this to the server: \(myUrl)")
            
            let task = session.dataTaskWithRequest(request) {
                (let data, let response, let error) in
                if error != nil {
                    self.delegate?.onError("Problem while contacting server")
                } else {
                    print("Rawresponse is: \(NSString(data: data!, encoding:NSUTF8StringEncoding))")
                    self.processCookie(data)
                }
            }
            task.resume()
        } else {
            delegate?.onError("Problem with url")
        }
    }
    
    func processCookie(body :NSData?) {
        let myJson = MYJSONParser()
        if let json = myJson.parseDictionnary(body) {
            if let data = json["data"] {
                if let status = data["status"],
                
                accountId = data["acct_id"], nick = data["nick"], actorId = data["actor_id"], authCookie = data["auth_cookie"] {
                    if (status as? String == "OK") {
                    let loginResponse = LoginResponse()
                    loginResponse.accountId = accountId as? String
                    loginResponse.nick = nick as? String
                    loginResponse.authCookie = authCookie as? String
                    loginResponse.email = email! as String
                    self.accountId = accountId as? String
                    self.nick = nick as? String
                    self.actorId = actorId as? String
                    self.authCookie = authCookie as? String
                    delegate?.onResult(loginResponse)
                    } else {
                        delegate?.onError("Credentials error")
                    }
                }
            } else {
                delegate?.onError("Something is status present in the JSON stream ??")
            }
        }
    }// end of processCookie
    
}