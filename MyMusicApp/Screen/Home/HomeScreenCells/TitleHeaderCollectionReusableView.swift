//
//  TitleHeaderCollectionReusableView.swift
//  MyMusicApp
//
//  Created by Borisov Nikita on 13.06.2023.
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifire = "TitleHeaderCollectionReusableView"
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String) {
        label.text = title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 10, y: 0, width: width-30, height: height)
    }
}
