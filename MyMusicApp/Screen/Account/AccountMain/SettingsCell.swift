//
//  SettingsCell.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-13.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        configureElements()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(iconImageView)
        addSubview(titleLabel)
    }
    
    func configureElements() {
        titleLabel.textColor = .white
        titleLabel.font = CommonConstant.FontSize.font14
        backgroundColor = .maBackground
//        backgroundColor = CommonConstant.Color.background
    }
    
    func setupConstraints() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
        iconImageView.heightAnchor.constraint(equalToConstant: 20),
        iconImageView.widthAnchor.constraint(equalToConstant: 20),

        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 20),
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        
        ])
    }
}
