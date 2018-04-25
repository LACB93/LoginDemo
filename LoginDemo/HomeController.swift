//
//  HomeController.swift
//  LoginDemo
//
//  Created by Gonet on 16/04/18.
//  Copyright © 2018 Gonet. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class HomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
     
    @IBAction func logoutUser(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "USUARIOREGISTRADO")
        self.navigationController?.popToRootViewController(animated: true )
        print("--- Sesión cerrada ---")
        let _: String? = KeychainWrapper.standard.string(forKey: "userUser")
        let _: String? = KeychainWrapper.standard.string(forKey: "userPassword")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
