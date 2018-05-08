//
//  lastViewController.swift
//  LoginDemo
//
//  Created by Gonet on 30/04/18.
//  Copyright © 2018 Gonet. All rights reserved.
//

import UIKit
import Localize_Swift


class LastViewController: HomeController {
    @IBOutlet weak var surverLabel: UILabel!
    @IBOutlet weak var singOff: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTexts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(setTexts), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func setTexts(){
        surverLabel.text = "Gracias por contestar la encuesta".localized()
        singOff.setTitle("Cerrar Sesión".localized(using: "ButtonsTitles"), for: UIControlState.normal)
    }
    
}
