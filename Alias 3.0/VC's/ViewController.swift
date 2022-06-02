//
//  ViewController.swift
//  Alias 3.0
//
//  Created by admin on 05.05.2022.
//  Copyright © 2022 Sergey Lolaev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func goToRegistration(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let registrationViewController =  storyboard.instantiateViewController(withIdentifier: "RegistrationViewControllerID") as! RegistrationViewController
        present(registrationViewController, animated: true, completion: nil)
        
    }
    
}

