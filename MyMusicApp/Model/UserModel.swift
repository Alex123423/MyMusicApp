//
//  UserModel.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-16.
//

import UIKit

struct UserModel {
    
    let idUuid: String
    let name: String?
    let email: String
    let dateBirth: Date?
    let gender: String?
    let avatarImage: UIImage?
    
    init(idUuid: String,
         name: String?,
         email: String,
         dateBirth: Date?,
         gender: String?,
         location: String?,
         avatarImage: UIImage?) {
        self.idUuid = idUuid
        self.name = name
        self.email = email
        self.dateBirth = dateBirth
        self.gender = gender
        self.avatarImage = avatarImage
    }
}
