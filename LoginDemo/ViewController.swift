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
    @IBOutlet weak var mensajeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if UserDefaults.standard.bool(forKey: "USUARIOREGISTRADO") == true {
            let Home = self.storyboard?.instantiateViewController(withIdentifier: "HomeController") as! HomeController
            self.navigationController?.pushViewController(Home, animated: false)
        }
        
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let retry = UIAlertAction(title: "Intentar otra vez", style: .default) { (action) in
            self.mensajeLabel.text = ""
            self.userName.text = ""
            self.passwordField.text = ""
            self.userName.becomeFirstResponder()
        }
        
//        let cancelar = UIAlertAction(title: "Cancelar", style: .default, handler: {(action) in
//
//            self.mensajeLabel.text = ""
//            self.userName.text = ""
//            self.passwordField.text = ""
//
//        })
        
        alert.addAction(retry)
//        alert.addAction(cancelar)
        present(alert, animated: true, completion: nil)
    }

    @IBAction func authenticateUser(_ sender: Any) {
        
        let usrName = userName.text
        if userName.text == "gonet" && passwordField.text == "gonet" {
            UserDefaults.standard.set(true, forKey: "USUARIOREGISTRADO")
            let Home = self.storyboard?.instantiateViewController(withIdentifier: "HomeController") as! HomeController
            self.navigationController?.pushViewController(Home, animated: true)
            print("Inicio de sesión de \(usrName!)")
        }else{
            self.mensajeLabel.text = "Credenciales Invalidas"
            showAlert(title: "Credenciales Invalidas", message: "Ingresa nuevamente tu usuario y contraseña")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

