//
//  LoginViewController.swift
//  loginTime
//
//  Created by Xavier Heroult on 04/04/2016.
//  Copyright © 2016 Xavier Heroult. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, BackendDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    var login: Login?
    var loginResp : NSString? = ""
    var loginState = LoginState.sharedIntance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func HelloWorldAction(sender: AnyObject) {
        if let em  = email.text, pass = password.text {
            let login = Login(login: em, password: pass, delegate: self)
            login.log()
        } else {
            print ("credentials are not filled")
        }
    }
    
    /**
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "myGroups" {
            let myGroupsVC = segue.destinationViewController as! MyGroupsViewController
            let login = sender as! LoginResponse
            myGroupsVC.login = login
        }
    }*/
    
    func decodeResponse() {
        print(loginResp)
    }
    
    
    func onResult(response: LoginResponse) {
        saveUserData(response)
        loginState.loginResponse = response
        loginState.updateLogged("Logged in \\o/")
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    func saveUserData(response: LoginResponse) {
         NSUserDefaults.standardUserDefaults().setObject(response.authCookie, forKey: "authCookie")
         NSUserDefaults.standardUserDefaults().setObject(response.nick, forKey: "nick")
         NSUserDefaults.standardUserDefaults().setObject(response.accountId, forKey: "accountId")
         NSUserDefaults.standardUserDefaults().setObject(response.email, forKey: "email")
    }
  
    func onError(response: String) {
        displayError()
    }

    func displayError() {
        let alert = UIAlertController(title: "Problème", message: "Mauvais login et/ou mot de passe. Vous pouvez reéssayer. Bien cordialement.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}

