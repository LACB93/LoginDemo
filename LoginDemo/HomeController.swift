//
//  HomeController.swift
//  LoginDemo
//
//  Created by Gonet on 16/04/18.
//  Copyright © 2018 Gonet. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import RealmSwift

class HomeController: UIViewController{

    @IBOutlet weak var opinion: UITextField!
//    @IBOutlet weak var favoriteTeam: UITextField!
//    @IBOutlet weak var favoritePlayer: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var position: UITextField!
    @IBOutlet weak var feliz: UIButton!
    @IBOutlet weak var enamorado: UIButton!
    @IBOutlet weak var enojado: UIButton!
    @IBOutlet weak var loco: UIButton!
    @IBOutlet weak var chivas: UIButton!
    @IBOutlet weak var azul: UIButton!
    @IBOutlet weak var pumas: UIButton!
    @IBOutlet weak var america: UIButton!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
     
    @IBAction func logoutUser(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "USUARIOREGISTRADO")
        self.navigationController?.popToRootViewController(animated: true )
        print("--- Sesión cerrada ---")
    }
    
    func buttonSelectedNot(){
        feliz.isSelected = false
        enamorado.isSelected = false
        enojado.isSelected = false
        loco.isSelected = false
    }

    @IBAction func save(_ sender: UIButton) {
        buttonSelectedNot()

        sender.isSelected = !sender.isSelected
        if(sender.isSelected){
            sender.isSelected = true
            let emojiString = (sender.titleLabel?.text)!
            sender.setTitleColor(UIColor.black, for: .selected)
            print(emojiString)
        }else {
            print("No seleccionado")
        }
         sender.isSelected = true
        
        guard let answer1 = opinion.text else {return}
        guard let answer2 = chivas.titleLabel?.text else {return}
//        guard let answer2 = favoriteTeam.text else {return}
        guard let answer3 = feliz.titleLabel?.text else {return}
        guard let answer4 = age.text else {return}
        guard let answer5 = position.text else {return}
        
        let newAnswer = Answers()
        
        newAnswer.answer1 = answer1
        newAnswer.answer2 = answer2
        newAnswer.answer3 = answer3
        newAnswer.answer4 = answer4
        newAnswer.answer5 = answer5
        
        try! self.realm.write {
            self.realm.add(newAnswer)
        }
        
        print(newAnswer)
        print("--- Datos Guardados ---")
        let Last = self.storyboard?.instantiateViewController(withIdentifier: "LastViewController") as! LastViewController
        self.navigationController?.pushViewController(Last, animated: true)
    }
    
}
