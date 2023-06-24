//
//  NotificationCell.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-23.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    private let trackNameLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let trackImageView = UIImageView()
     var dateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        configureElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(trackName: String, artistname: String, date: String) {
        self.trackNameLabel.text = trackName
        self.subTitleLabel.text = artistname
        self.dateLabel.text = date
    }
}

extension NotificationCell {
    
    private func setupViews() {
        addSubview(trackImageView)
        addSubview(trackNameLabel)
        addSubview(subTitleLabel)
        addSubview(dateLabel)
        self.selectionStyle = .none
        self.backgroundColor = .maBackground
    }
    
    private func configureElements() {
        selectionStyle = .none
        trackImageView.translatesAutoresizingMaskIntoConstraints = false
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        trackImageView.layer.cornerRadius = 15
        trackImageView.image = UIImage(named: "imageimage")
        
        trackNameLabel.text = "Song has been donwloaded"
        trackNameLabel.textAlignment = .left
        trackNameLabel.textColor = .maLightGray
        trackNameLabel.font = CommonConstant.FontSize.fontBold12
//        trackNameLabel.adjustsFontSizeToFitWidth = true
        
        subTitleLabel.text = "Song name here"
        subTitleLabel.textAlignment = .left
        subTitleLabel.textColor = .maLightGray
        subTitleLabel.font = CommonConstant.FontSize.font12
//        subTitleLabel.adjustsFontSizeToFitWidth = true
        
        dateLabel.text = "5:50 PM"
        dateLabel.textColor = .systemBlue
        dateLabel.font = CommonConstant.FontSize.fontBold12
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            trackImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            trackImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            trackImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            trackImageView.widthAnchor.constraint(equalToConstant: 70),
            
            trackNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            trackNameLabel.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: 5),
            trackNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            
            subTitleLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 4),
            subTitleLabel.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: 5),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
