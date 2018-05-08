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
import RealmSwift
import SwiftKeychainWrapper
import Localize_Swift

class ViewController: UIViewController {
    @IBOutlet weak var userName: UITextField!    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var changeButton: UIButton!
    var actionSheet: UIAlertController!
    
    let availableLanguages = Localize.availableLanguages()
    
    let realm = try! Realm()
    var usersList : Results<Users>!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setText()
        usersList = realm.objects(Users.self)
        print(usersList)
        if UserDefaults.standard.bool(forKey: "USUARIOREGISTRADO") == true {
            let Home = self.storyboard?.instantiateViewController(withIdentifier: "HomeController") as! HomeController
            self.navigationController?.pushViewController(Home, animated: true)
        } else {
            let retrievedUser: String? = KeychainWrapper.standard.string(forKey: "userUser")
            let retrievedPassword: String? = KeychainWrapper.standard.string(forKey: "userPassword")
            userName.text = retrievedUser
            passwordField.text = retrievedPassword

        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
    }
    
    // Remove the LCLLanguageChangeNotification on viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let retry = UIAlertAction(title: NSLocalizedString("TRY_AGAIN", comment: "Intentar otra vez"), style: .default) { (action) in
            self.userName.text = ""
            self.passwordField.text = ""
            self.userName.becomeFirstResponder()
        }
        
        alert.addAction(retry)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addUser(_ sender: Any) {
        let alerta = UIAlertController(title: NSLocalizedString("NEW_USER", comment: "Nuevo usuario"), message: NSLocalizedString("ENTER_NEW_USER", comment: "Ingrese nuevo usuario"), preferredStyle: .alert)
        alerta.addTextField{ (usuario) in
            usuario.placeholder = NSLocalizedString("USER", comment: "Usuario")
        }
        
        alerta.addTextField{ (contraseña) in
            contraseña.placeholder = NSLocalizedString("PASSWORD", comment: "Contraseña")
            contraseña.isSecureTextEntry = true
        }
        
        let save = UIAlertAction(title: NSLocalizedString("SAVE", comment: "Guardar"), style: .default) { (action) in
            guard let usuario = alerta.textFields?.first?.text else {return}
            guard let contraseña = alerta.textFields?[1].text else {return}
            
            let newUser = Users()
            newUser.usuario = usuario
            newUser.contraseña = contraseña
            
            try! self.realm.write {
                self.realm.add(newUser )
            }
            
            print(NSLocalizedString("REGISTERED_USER", comment: "Nuevo usuario registrado"))
            
        }
        
        let cancel = UIAlertAction(title: NSLocalizedString("CANCEL", comment: "Cancelar"), style: .destructive, handler: nil)
        
        alerta.addAction(save)
        alerta.addAction(cancel)
        present(alerta, animated: true, completion: nil)
    }
    
    func deleteDatabase() {
        try! realm.write({
            realm.deleteAll()
        })
    }
    
    @objc func setText(){
        changeButton.setTitle("Change".localized(using: "Localizable"), for: UIControlState.normal)
//        changeButton.setTitle("Change".localized(using: "Main"), for: UIControlState.normal)
    }
    
    
    @IBAction func doChangeLanguage(_ sender: UIButton) {
        actionSheet = UIAlertController(title: nil, message: "Switch Language", preferredStyle: UIAlertControllerStyle.actionSheet)
        for language in availableLanguages {
            let displayName = Localize.displayNameForLanguage(language)
            let languageAction = UIAlertAction(title: displayName, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                Localize.setCurrentLanguage(language)
            })
            actionSheet.addAction(languageAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {
            (alert: UIAlertAction) -> Void in
        })
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // *** Autenticación con Realm ***
    
    @IBAction func authenticateUser(_ sender: Any) {
        let usrName = userName.text
        let usuarios = usersList
        // Solo si encuentra un usuario valido, va a poder hacer login
        var isLoginExitoso = false
        for users in usuarios! {
            let usr = users.usuario
            let pw = users.contraseña

            if self.userName.text == usr && self.passwordField.text == pw {
                isLoginExitoso = true
                break
            }
        }
        if isLoginExitoso {
            print("--- Inicio de sesión de \(usrName!) ---")
            let Home = self.storyboard?.instantiateViewController(withIdentifier: "HomeController") as! HomeController
            self.navigationController?.pushViewController(Home, animated: true)
        } else {
            self.showAlert(title: NSLocalizedString("INVALID_CREDENTIALS", comment: "Credenciales inválidas"), message: NSLocalizedString("ENTER_CREDENTIALS_AGAIN", comment: "Ingresa nuevamente tu usuario y contraseña"))
        }
        
        if self.userName.text == "" || self.passwordField.text == "" {
            let alertController = UIAlertController(title: "Error", message: NSLocalizedString("ENTER_EMAIL_PW", comment: "Por favor introduce email y contraseña"), preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    // *** Autenticación con Firebase ***
    
//    @IBAction func authenticateUser(_ sender: Any) {
//        let usrName = userName.text
        
//        if self.userName.text == "" || self.passwordField.text == "" {
//            let alertController = UIAlertController(title: "Error", message: "Por favor introduce email y contraseña", preferredStyle: .alert)
//
//            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//            alertController.addAction(defaultAction)
//
//            self.present(alertController, animated: true, completion: nil)
//
//        } else {
//            Auth.auth().signIn(withEmail: self.userName.text!, password: self.passwordField.text!) { (user, error) in
//                if error == nil {
//                    UserDefaults.standard.set(true, forKey: "USUARIOREGISTRADO")
//                    let Home = self.storyboard?.instantiateViewController(withIdentifier: "HomeController") as! HomeController
//                    self.navigationController?.pushViewController(Home, animated: true)
//                    print("--- Inicio de sesión de \(usrName!) ---")
//
//                } else {
//                    self.showAlert(title: "Credenciales Invalidas", message: "Ingresa nuevamente tu email y contraseña")
//                }
//             }
    
    @IBAction func savePasswordButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
            if let user = userName.text, let password = passwordField.text{
                let _: Bool = KeychainWrapper.standard.set(user, forKey: "userUser")
                let _: Bool = KeychainWrapper.standard.set(password, forKey: "userPassword")
                self.view.endEditing(true)
            }
        }
    }
    
    @IBAction func returntest (segue: UIStoryboardSegue!){
        print(NSLocalizedString("CLOSED_SESSION", comment: "Sesión cerrada"))
    }
}




