//
//  MainViewController.swift
//  StundenplanAppModel
//
//  Created by MACBOOK on 15.10.20.
//  Copyright © 2020 kaw_solutions. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{
    @IBOutlet weak var infoText: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func fetchButtonTouched(_ sender: Any) {
        Connection().fetch(url: Constants.baseURI, username: Constants.username, password: Constants.password)
        
    }
    
    func setText(text:String) -> Void{
        infoText.text = text
    }
    
}
