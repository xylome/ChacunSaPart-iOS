//
//  MainViewController.swift
//  loginTime
//
//  Created by Xavier Heroult on 07/04/2016.
//  Copyright © 2016 Xavier Heroult. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

   
    @IBOutlet weak var topTitleConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainTitleLabel: UILabel!
    let mainModel = MainViewModel()
    var loginState = LoginState.sharedIntance
    var myCspContext = 42
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginState.addObserver(self, forKeyPath: "logged", options: .New, context: &myCspContext)
        
        if (!mainModel.isLoggedIn()) {
            startLogin()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (loginState.logged == "Logged") {
            refreshLoginInfo()
        }
        
        print("view did appear")
    }
    
    func refreshLoginInfo() {
        if let nick = loginState.loginResponse?.nick {
            print("Hello Yunus!")
            mainTitleLabel.text = "Hello " + nick + " ! "
            topTitleConstraint.constant = 10
            mainTitleLabel.alpha = 1
            UIView.animateWithDuration(1, delay: 0, options: [.CurveEaseOut], animations: {
            
                self.view.layoutIfNeeded()
                }, completion: nil)
            }
    }
    
    func startLogin() {
        let loginController = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()
        navigationController?.presentViewController(loginController!, animated: false, completion: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &myCspContext {
            if let newValue = change?[NSKeyValueChangeNewKey] {
                print("New value for logint state: \(newValue)")
                print("New state singleton value is: \(loginState.logged)")
            }
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    deinit {
        loginState.removeObserver(self, forKeyPath: "logged", context: &myCspContext)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
