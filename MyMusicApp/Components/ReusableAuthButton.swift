//
//  ReusableAuthButton.swift
//  Firebase_Tasks
//
//  Created by Vitali Martsinovich on 2023-06-09.
//

import UIKit

final class ReusableAuthButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String, target: Any?, action: Selector) {
        self.init(type: .system)
        self.addTarget(target, action: action, for: .touchUpInside)
        self.setTitle(title, for: .normal)
        self.backgroundColor = .maCustomYellow
        self.contentMode = .center
        self.titleLabel?.font = CommonConstant.FontSize.fontBold16
        self.titleLabel?.tintColor = .maButtonText
        self.layer.cornerRadius = 5
        self.titleLabel?.textColor = .maButtonText
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
