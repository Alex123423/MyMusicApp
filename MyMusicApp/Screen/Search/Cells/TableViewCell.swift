//
//  TableViewCell.swift
//  MyMusicApp
//
//  Created by Dmitry Medvedev on 13.06.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class TableViewCell: UITableViewCell {
    
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
    
     lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "settingsButton"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
    }
    
    func configureCellWithSecondLabel(image: URL?, firstText: String?, secondText: String?) {
        firstLabel.snp.removeConstraints()
        addSubview(singerImage)
        addSubview(settingsButton)
        addSubview(firstLabel)
        addSubview(secondLabel)
        
        singerImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.height.width.equalTo(40)
        }
        
        firstLabel.snp.makeConstraints { make in
            make.leading.equalTo(singerImage.snp.trailing).offset(16)
            make.trailing.equalTo(settingsButton.snp.leading).offset(-16)
            make.top.equalTo(singerImage.snp.top)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.leading.equalTo(singerImage.snp.trailing).offset(16)
            make.trailing.equalTo(settingsButton.snp.leading).offset(-16)
            make.bottom.equalTo(singerImage.snp.bottom)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-24)
            make.height.width.equalTo(24)
        }
        
        if image != nil {
            singerImage.kf.setImage(with: image)
        } else {
            singerImage.image = UIImage(named: "imageimage")
        }
        
        if firstText != nil {
            firstLabel.text = firstText
        } else {
            firstLabel.text = "Очень крутая песня"
        }
        
        if secondText != nil {
            secondLabel.text = secondText
        } else {
            secondLabel.text = "Очень клевый исполнитель"
        }
    }
    
    func configureCellWithoutSecondLabel(image: URL?, firstText: String?) {
        secondLabel.removeFromSuperview()
        firstLabel.snp.removeConstraints()
        addSubview(singerImage)
        addSubview(settingsButton)
        addSubview(firstLabel)
        
        singerImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.height.width.equalTo(40)
        }
        
        firstLabel.snp.makeConstraints { make in
            make.centerY.equalTo(singerImage)
            make.leading.equalTo(singerImage.snp.trailing).offset(16)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-24)
            make.height.width.equalTo(24)
        }
        
        if image != nil {
            singerImage.kf.setImage(with: image)
        } else {
            singerImage.image = UIImage(named: "imageimage")
        }
        
        if firstText != nil {
            firstLabel.text = firstText
        } else {
            firstLabel.text = "Очень крутой альбом"
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        singerImage.image = nil
        firstLabel.text = nil
        secondLabel.text = nil
    }
}
