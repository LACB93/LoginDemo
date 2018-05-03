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

enum Emojis: String {
    case enojado = "😡"
    case loco = "🤪"
    case feliz = "😀"
    case enamorado = "😍"
    case sinSeleccionar = "No seleccionado"
    
}

enum Teams: String {
    case chivas = "Chivas"
    case azul = "Cruz Azul"
    case pumas = "Pumas"
    case america = "America"
    case sinSeleccionar = "No seleccionado"
}

class HomeController: UIViewController{

    @IBOutlet weak var opinion: UITextField!
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

    @IBAction func ChivasBtn(_ sender: UIButton) {
        sender.setTitleColor(UIColor.white, for: .selected)
        chivas.isSelected = true
//        azul.isEnabled = false
//        pumas.isEnabled = false
//        america.isEnabled = false
        azul.isSelected = false
        pumas.isSelected = false
        america.isSelected = false
    }
    
    @IBAction func AzulBtn(_ sender: UIButton) {
        sender.setTitleColor(UIColor.white, for: .selected)
        azul.isSelected = true
//        chivas.isEnabled = false
//        pumas.isEnabled = false
//        america.isEnabled = false
        chivas.isSelected = false
        pumas.isSelected = false
        america.isSelected = false
    }
    
    @IBAction func PumasBtn(_ sender: UIButton) {
        sender.setTitleColor(UIColor.white, for: .selected)
        pumas.isSelected = true
//        chivas.isEnabled = false
//        azul.isEnabled = false
//        america.isEnabled = false
        chivas.isSelected = false
        azul.isSelected = false
        america.isSelected = false
    }
    
    @IBAction func AmericaBtn(_ sender: UIButton) {
        sender.setTitleColor(UIColor.white, for: .selected)
        america.isSelected = true
//        chivas.isEnabled = false
//        azul.isEnabled = false
//        pumas.isEnabled = false
        chivas.isSelected = false
        azul.isSelected = false
        pumas.isSelected = false
    }
    
    @IBAction func HappyBtn(_ sender: UIButton) {
        sender.setTitleColor(UIColor.white, for: .selected)
        feliz.isSelected = true
//        enamorado.isEnabled = false
//        enojado.isEnabled = false
//        loco.isEnabled = false
        enamorado.isSelected = false
        enojado.isSelected = false
        loco.isSelected = false
    }
    
    @IBAction func LoveBtn(_ sender: UIButton) {
        sender.setTitleColor(UIColor.white, for: .selected)
        enamorado.isSelected = true
//        feliz.isEnabled = false
//        enojado.isEnabled = false
//        loco.isEnabled = false
        feliz.isSelected = false
        enojado.isSelected = false
        loco.isSelected = false
    }
    
    @IBAction func AngryBtn(_ sender: UIButton) {
        sender.setTitleColor(UIColor.white, for: .selected)
        enojado.isSelected = true
//        feliz.isEnabled = false
//        enamorado.isEnabled = false
//        loco.isEnabled = false
        feliz.isSelected = false
        enamorado.isSelected = false
        loco.isSelected = false
    }
    
    @IBAction func CrazyBtn(_ sender: UIButton) {
        sender.setTitleColor(UIColor.white, for: .selected)
        loco.isSelected = true
//        feliz.isEnabled = false
//        enamorado.isEnabled = false
//        enojado.isEnabled = false
        feliz.isSelected = false
        enamorado.isSelected = false
        enojado.isSelected = false
    }
    
    @IBAction func clean(_ sender: UIButton) {
        opinion.text = ""
//        chivas.isEnabled = true
//        azul.isEnabled = true
//        pumas.isEnabled = true
//        america.isEnabled = true
        age.text = ""
        position.text = ""
        chivas.isSelected = false
        azul.isSelected = false
        pumas.isSelected = false
        america.isSelected = false
//        feliz.isEnabled = true
//        enamorado.isEnabled = true
//        enojado.isEnabled = true
//        loco.isEnabled = true
        feliz.isSelected = false
        enamorado.isSelected = false
        enojado.isSelected = false
        loco.isSelected = false
    }
    
   
    var selectEmoji: Emojis = .sinSeleccionar
    
    @IBAction func EmojiPressed(_ sender: UIButton) {
       

        switch sender {
        case feliz: selectEmoji = .feliz
        case enamorado: selectEmoji = .enamorado
        case enojado: selectEmoji = .enojado
        case loco: selectEmoji = .loco
        default: break
        }
    }
    
    var selectTeam: Teams = .sinSeleccionar
    
    @IBAction func TeamsPressed(_ sender: UIButton) {
        switch sender {
        case chivas: selectTeam = .chivas
        case azul: selectTeam = .azul
        case pumas: selectTeam = .pumas
        case america: selectTeam = .america
        default: break
        }
    }
    
    
    
    @IBAction func save(_ sender: UIButton) {
        
        if opinion.text == "" || age.text == "" || position.text == "" || selectTeam == .sinSeleccionar || selectEmoji == .sinSeleccionar {
            let alertController = UIAlertController(title: "Error", message: "Por favor llena o selecciona todas las opciones", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        guard let answer1 = opinion.text else {return}
        if selectTeam == .sinSeleccionar {return}
        let answer2 = selectTeam.rawValue
        if selectEmoji == .sinSeleccionar { return }
        let answer3 = selectEmoji.rawValue
        
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
    
        print(newAnswer)
        print("--- Datos Guardados ---")
        let Last = self.storyboard?.instantiateViewController(withIdentifier: "LastViewController") as! LastViewController
        self.navigationController?.pushViewController(Last, animated: true)
        }
    }
}
