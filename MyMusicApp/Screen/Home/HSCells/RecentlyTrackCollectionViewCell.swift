//
//  RecentlyTrackCollectionViewCell.swift
//  MyMusicApp
//
//  Created by Borisov Nikita on 14.06.2023.
//

import UIKit
import Kingfisher

class RecentlyTrackCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "RecentlyTrackCollectionViewCell"
    private let trackNameLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let trackCoverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 3
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let artistNameLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .thin)
        return label
    }()
    
    let trackNumberLbl: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.cornerRadius = 25
        let image = UIImage(systemName: "play", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light))
        button.setImage(image, for: .normal)
        button.layer.masksToBounds = true
        button.tintColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 10
        contentView.addSubview(trackCoverImage)
        contentView.addSubview(trackNameLbl)
        contentView.addSubview(artistNameLbl)
        contentView.addSubview(trackNumberLbl)
        contentView.addSubview(playButton)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize: CGFloat = contentView.height-20
        
        let albumLAbelSize = trackNameLbl.sizeThatFits(CGSize(
            width: contentView.width-imageSize-10, height: contentView.height-10))
        
        artistNameLbl.sizeToFit()
        
        trackCoverImage.frame = CGRect(x: 50, y: 10, width: imageSize, height: imageSize)
        
        let albumLabelHeight = min(55, albumLAbelSize.height)
        
        trackNameLbl.frame = CGRect(
            x: trackCoverImage.right+10 ,
            y: trackCoverImage.top,
            width: albumLAbelSize.width ,
            height: albumLabelHeight)
        
        artistNameLbl.frame = CGRect(
            x: trackCoverImage.right+10 ,
            y: trackNameLbl.bottom,
            width: contentView.width - trackCoverImage.right-10 ,
            height: 30)
        
        trackNumberLbl.frame = CGRect(
            x: 10,
            y: trackCoverImage.height/2,
            width: 25,
            height: 15)
        
        playButton.frame = CGRect(
            x: contentView.width-70,
            y: 10 ,
            width: 50,
            height: 50)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLbl.text = nil
        artistNameLbl.text = nil
        trackCoverImage.image = nil
        trackNumberLbl.text = nil
    }
    
    func configureCells(model: HomeScreenViewReusebleModel) {
        artistNameLbl.text = model.artistName
        trackNameLbl.text = model.trackName
        trackCoverImage.image = UIImage(named: model.imageCover )
    }
    
}
