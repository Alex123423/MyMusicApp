//
//  CollectionViewCell.swift
//  MyMusicApp
//
//  Created by Dmitry Medvedev on 13.06.2023.
//

import UIKit
import SnapKit

final class CollectionViewCell: UICollectionViewCell {
    
    private lazy var label: UILabel = {
        let element = UILabel()
        element.textColor = .maCollectionTextColor
        element.font = .boldSystemFont(ofSize: 16)
        return element
    }()
    
    private lazy var stripeImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(text: String) {
        label.text = text
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                addSubview(stripeImage)
                label.font = .boldSystemFont(ofSize: 22)
                label.textColor = .white
                
                label.snp.makeConstraints { make in
                    make.top.equalToSuperview()
                    make.centerX.equalToSuperview()
                }
                
                stripeImage.snp.makeConstraints { make in
                    make.height.equalTo(4)
                    make.leading.trailing.bottom.equalToSuperview()
                }
            } else {
                stripeImage.removeFromSuperview()
                
                label.font = .boldSystemFont(ofSize: 16)
                label.textColor = .maCollectionTextColor
                
                label.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                }
            }
        }
    }
    
//    func configureCellWithSelect() {
//        addSubview(stripeImage)
//        
//        label.font = .boldSystemFont(ofSize: 22)
//        label.textColor = .white
//        
//        label.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.centerX.equalToSuperview()
//        }
//        
//        stripeImage.snp.makeConstraints { make in
//            make.height.equalTo(4)
//            make.leading.trailing.bottom.equalToSuperview()
//        }
//    }
    
//    func configureCellWithoutSelect() {
//        stripeImage.removeFromSuperview()
//        
//        label.font = .boldSystemFont(ofSize: 16)
//        label.textColor = .maCollectionTextColor
//        
//        label.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//        }
//    }
    
    private func setupView() {
        addSubview(label)
    }

    private func setupConstraints() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
