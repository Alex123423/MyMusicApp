//
//  NewSongReusebleCell.swift
//  MyMusicApp
//
//  Created by Borisov Nikita on 13.06.2023.
//

import UIKit
import Kingfisher

class NewSongReusebleViewCell: UICollectionViewCell {
    
    static let identifire = "NewSongReusebleViewCell"
    
    private let imageCover: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "imageimage")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let trackNameLbl: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        //contentView.clipsToBounds = true
        contentView.addSubview(imageCover)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageCover.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height-50)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageCover.image = nil
    }
    
}
