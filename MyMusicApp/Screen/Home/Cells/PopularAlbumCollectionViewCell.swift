//
//  PopularAlbumCollectionViewCell.swift
//  MyMusicApp
//
//  Created by Borisov Nikita on 14.06.2023.
//

import UIKit
import Kingfisher

class PopularAlbumCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "PopularAlbumCollectionViewCell"
    
    private let imageCover: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "image2")
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let trackNameLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let artistNameLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let colors: [UIColor] = [
        .systemMint,
        .systemPink,
        .systemBlue,
        .systemTeal,
        .systemBrown,
        .systemIndigo,
        .systemOrange,
        .systemPurple,
        .systemYellow
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = colors.randomElement()
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        contentView.addSubview(imageCover)
        contentView.addSubview(trackNameLbl)
        contentView.addSubview(artistNameLbl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageCover.frame = CGRect(
            x: contentView.width/2,
            y: 0,
            width: contentView.width/2,
            height: contentView.height)
        
        trackNameLbl.frame = CGRect(
            x: 15,
            y: contentView.height/2.2,
            width: contentView.width,
            height: 20)
        
        artistNameLbl.frame = CGRect(
            x: 15,
            y: trackNameLbl.bottom+5,
            width: contentView.width,
            height: 20)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageCover.image = nil
        trackNameLbl.text = nil
        artistNameLbl.text = nil
    }
    
    func configureCells(model: HomeScreenViewReusebleModel) {
        imageCover.image = UIImage(named: model.imageCover)
        trackNameLbl.text = model.trackName
        artistNameLbl.text = model.artistName
    }
}
