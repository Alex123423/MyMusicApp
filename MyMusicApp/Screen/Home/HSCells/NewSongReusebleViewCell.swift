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
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.text = "Save Your Tears"
        return label
    }()
    
    private let artistNameLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.text = "The Weeknd"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
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
            x: 0,
            y: 0,
            width: contentView.width,
            height: contentView.height-50)
        
        trackNameLbl.frame = CGRect(
            x: 5,
            y: imageCover.bottom+5,
            width: contentView.width,
            height: 15)
        
        artistNameLbl.frame = CGRect(
            x: 5,
            y: trackNameLbl.bottom+5,
            width: contentView.width,
            height: 15)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageCover.image = nil
        trackNameLbl.text = nil
        artistNameLbl.text = nil
    }
    
    func configureCells(model: Album) {
        guard let UirlString600 = (model.artworkUrl60?.replacingOccurrences(of: "60x60", with: "600x600")) else { return }
        imageCover.kf.setImage(with: URL(string: UirlString600))
        trackNameLbl.text = model.trackName
        artistNameLbl.text = model.artistName
        
    }
    
}
