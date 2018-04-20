//
//  ViewController.swift
//  LoginDemo
//
//  Created by Gonet on 16/04/18.
//  Copyright © 2018 Gonet. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var userName: UITextField!    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var mensajeLabel: UILabel!
    @IBOutlet weak var switchController: UISwitch!
    
    
    override func viewDidLoad() {
        
        switchController.addTarget(self, action: #selector(self.rememberSwitch), for: .valueChanged)
        
        if UserDefaults.standard.bool(forKey: "USUARIOREGISTRADO") == false {
            userName.text = UserDefaults.standard.string(forKey: "savedUserName")
            passwordField.text = UserDefaults.standard.string(forKey: "savedPassword")
        }
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if UserDefaults.standard.bool(forKey: "USUARIOREGISTRADO") == false {
            switchController.setOn(true, animated: false)
        }
        else {
            switchController.setOn(false, animated: false)
        }
        
//        userName.text = UserDefaults.standard.string(forKey: "savedUserName")
//        passwordField.text = UserDefaults.standard.string(forKey: "savedPassword")
//        switchController.setOn(true, animated: false)
        if UserDefaults.standard.bool(forKey: "USUARIOREGISTRADO") == true {
            let Home = self.storyboard?.instantiateViewController(withIdentifier: "HomeController") as! HomeController
            self.navigationController?.pushViewController(Home, animated: false)
        }else {
            switchController.setOn(false, animated: false)
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
    
    
    @IBAction func rememberSwitch(_ switchState: UISwitch) {
        if switchState.isOn{
            UserDefaults.standard.set(true, forKey: "rememberme")
            UserDefaults.standard.set(userName.text, forKey: "savedUserName")
            UserDefaults.standard.set(passwordField.text, forKey: "savedPassword")
        }else {
            UserDefaults.standard.set(false, forKey: "USUARIOREGISTRADO")
            }
    }
    
    @IBAction func authenticateUser(_ sender: Any) {
        
        let usrName = userName.text
        
        
        if self.userName.text == "" || self.passwordField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Por favor introduce email y contraseña", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().signIn(withEmail: self.userName.text!, password: self.passwordField.text!) { (user, error) in
                if error == nil {
                    UserDefaults.standard.set(true, forKey: "USUARIOREGISTRADO")
                    let Home = self.storyboard?.instantiateViewController(withIdentifier: "HomeController") as! HomeController
                    self.navigationController?.pushViewController(Home, animated: true)
                    print("--- Inicio de sesión de \(usrName!) ---")
                    
                } else {
                    self.mensajeLabel.text = "Credenciales Invalidas"
                    self.showAlert(title: "Credenciales Invalidas", message: "Ingresa nuevamente tu email y contraseña")
                }
            }
        }
        
    }


}

