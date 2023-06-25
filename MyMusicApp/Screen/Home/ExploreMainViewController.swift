//
//  ExploreMainViewController.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 13.06.2023.
//

import UIKit

class ExploreMainViewController: UIViewController {
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Explore"
        label.textColor = .white
        label.font = CommonConstant.FontSize.fontBold18
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setConstrains()
    }
    
    func setupHierarchy() {
        view.backgroundColor = .maBackground
        view.addSubview(topLabel)
        
    }
    
    func setConstrains() {
        NSLayoutConstraint.activate([
            
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30),
            topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}
