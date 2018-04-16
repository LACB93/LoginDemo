//
//  ViewController.swift
//  LoginDemo
//
//  Created by Gonet on 16/04/18.
//  Copyright © 2018 Gonet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userName: UITextField!    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if UserDefaults.standard.bool(forKey: "USUARIOREGISTRADO") == true {
            let Home = self.storyboard?.instantiateViewController(withIdentifier: "HomeController") as! HomeController
            self.navigationController?.pushViewController(Home, animated: false)
        }
    }

    @IBAction func authenticateUser(_ sender: Any) {
        let usrName = userName.text
        if userName.text == "gonet" && passwordField.text == "gonet" {
            UserDefaults.standard.set(true, forKey: "USUARIOREGISTRADO")
            let Home = self.storyboard?.instantiateViewController(withIdentifier: "HomeController") as! HomeController
            self.navigationController?.pushViewController(Home, animated: true)
            print("Inicio de sesión de \(usrName!)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

