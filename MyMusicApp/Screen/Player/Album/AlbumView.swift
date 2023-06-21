//
//  AlbumViewController.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-14.
//

import UIKit

final class AlbumView {
    
    let albumImage: UIImageView = {
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
    
    let artistLabel = CustomLabel().createCustomLabel(text: "Shawn Mendes",
                                                      textColor: .white,
                                                      font: CommonConstant.FontSize.font18,
                                                      textAlignment: .left,
                                                      numberOfLines: 2)
    
    let songText: UILabel = {
        let label = UILabel()
        label.layer.borderColor = UIColor.white.cgColor
        label.font = UIFont.systemFont(ofSize: 14)
        label.font = CommonConstant.FontSize.font14
//        label.text = """
//                     It is a long established fact that a reader will be
//                     distracted by the readable content of a page when
//                     looking at its layout. The point of using Lorem Ipsum
//                     is that it
//                     """
        label.text = "It is a long established fact that a reader will be It is a long established fact that a reader will be It is a long established fact that a reader will be It is a long established fact that a reader will be"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let showMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show more >", for: .normal)
        button.setTitleColor(.maDarkGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
}
