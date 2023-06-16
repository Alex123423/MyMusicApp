//
//  AlbumTableViewCell.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 15.06.2023.
//

import UIKit
import SnapKit

final class AlbumTableViewCell: UITableViewCell {
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var singerImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 3
        return image
    }()
    
    private lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.textColor = .maSecondColorTableView
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "settingsButton"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        setupView()
        setupConstraints()
    }
    
    func configureCell(numberText: String?, image: UIImage?, firstText: String?, secondText: String?) {
        
        numberLabel.text = numberText
        singerImage.image = image
        firstLabel.text = firstText
        secondLabel.text = secondText
    }
    
    private func setupView() {
        addSubview(numberLabel)
        addSubview(singerImage)
        addSubview(firstLabel)
        addSubview(secondLabel)
        addSubview(settingsButton)
    }

    private func setupConstraints() {
        
        numberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()

        }
        singerImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(numberLabel.snp.trailing).offset(16)
            make.height.width.equalTo(40)
        }
        
        firstLabel.snp.makeConstraints { make in
            make.leading.equalTo(singerImage.snp.trailing).offset(16)
            make.top.equalTo(singerImage.snp.top)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.leading.equalTo(singerImage.snp.trailing).offset(16)
            make.bottom.equalTo(singerImage.snp.bottom)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
