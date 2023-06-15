//
//  ReusableGrayLine.swift
//  Firebase_Tasks
//
//  Created by Vitali Martsinovich on 2023-06-10.
//

import UIKit

final class ReusableGrayLine: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .maLightGray
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
