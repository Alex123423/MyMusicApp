//
//  FavouritesTableViewCell.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 19.06.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class FavouritesTableViewCell: UITableViewCell {
    
    private lazy var singerImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 3
        image.layer.masksToBounds = true
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
    
    func configureCell(image: URL?, firstText: String?, secondText: String?) {
        
        if image != nil {
            singerImage.kf.setImage(with: image)
        } else {
            singerImage.image = UIImage(named: "imageimage")
        }
        
        firstLabel.text = firstText
        secondLabel.text = secondText
        
    }
    
    private func setupView() {
        addSubview(singerImage)
        addSubview(firstLabel)
        addSubview(secondLabel)
        addSubview(settingsButton)
    }

    private func setupConstraints() {
        singerImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
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
            make.trailing.equalToSuperview().offset(-24)
        }
    }
}
