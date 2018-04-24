//
//  Users.swift
//  LoginDemo
//
//  Created by Gonet on 20/04/18.
//  Copyright © 2018 Gonet. All rights reserved.
//

import Foundation
import RealmSwift

class Users: Object {
    
    convenience init(usuario: String, contraseña: String){
        self.init()
        self.usuario = usuario
        self.contraseña = contraseña
    }
    
    @objc dynamic var usuario = ""
    @objc dynamic var contraseña = ""
}
