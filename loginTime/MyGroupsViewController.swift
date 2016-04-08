//
//  MyGroupsViewController.swift
//  loginTime
//
//  Created by Xavier Heroult on 06/04/2016.
//  Copyright © 2016 Xavier Heroult. All rights reserved.
//

import UIKit

class MyGroupsViewController : UIViewController {
   
    
    @IBOutlet weak var greetings: UILabel!
  
    var login: LoginResponse?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        greetings.text = "Hello " + (login?.nick)! + " !"
    }
    
}