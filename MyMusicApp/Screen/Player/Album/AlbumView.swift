//
//  AlbumViewController.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-14.
//

import UIKit

final class AlbumView {
    
    let albumImage100: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "image2")
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let vStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let songLabel = CustomLabel().createCustomLabel(text: "Come to me",
                                                    textColor: .white,
                                                    font: CommonConstant.FontSize.fontBold36,
                                                    textAlignment: .left,
                                                    numberOfLines: 1)
    
    let artistLabel = CustomLabel().createCustomLabel(text: "Shawn Mendes\n",
                                                      textColor: .white,
                                                      font: CommonConstant.FontSize.font18,
                                                      textAlignment: .left,
                                                      numberOfLines: 2)
    
    let songTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = CommonConstant.FontSize.font14
        label.numberOfLines = 4
        label.lineBreakMode = .byWordWrapping
        label.text = "It is a long established fact that a reader will\nbe distracted by the readable content of a\npage when looking at its layout. The point of\n using Lorem Ipsum is that it"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let showMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show more >", for: .normal)
        button.setTitleColor(.maDarkGray, for: .normal)
      //  button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    let separateImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "separateLine")
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let suggestionLabel = CustomLabel().createCustomLabel(text: "Suggestion",
                                                      textColor: .white,
                                                      font: CommonConstant.FontSize.fontBold18,
                                                      textAlignment: .left,
                                                      numberOfLines: 1)
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
       // tableView.separatorColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
}
