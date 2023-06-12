//
//  UIView + Ext.swift
//  Firebase_Tasks
//
//  Created by Vitali Martsinovich on 2023-06-08.
//

import UIKit

extension UIImageView {
    convenience init(imageName: UIImage) {
        self.init(image: imageName)
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}


