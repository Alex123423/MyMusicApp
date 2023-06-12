//
//  FourthScreenViewController.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 12.06.2023.
//

import UIKit

class FourthScreenViewController: UIViewController {
    
    let getStartedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(OnboardingConstant.Text.getStartedButton, for: .normal)
        button.titleLabel?.font = СommonConstant.FontSize.fontBold16
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = СommonConstant.Color.customYellow
        button.layer.cornerRadius = СommonConstant.Radius.radius8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = OnboardingConstant.Image.fourthOnboarding
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    var firstTitle = CustomLabel().createCustomLabel(text: OnboardingConstant.Text.music,
                                                     textColor: СommonConstant.Color.white,
                                                     font: СommonConstant.FontSize.fontBold64,
                                                     textAlignment: .left,
                                                     numberOfLines: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setConstrains()
    }
    
    func setupHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(firstTitle)
        view.addSubview(getStartedButton)
    }
        
    
    func setConstrains() {
        
        NSLayoutConstraint.activate([
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            firstTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            getStartedButton.heightAnchor.constraint(equalToConstant: 46),
            getStartedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: СommonConstant.Padding.leading40),
            getStartedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: СommonConstant.Padding.trailing40),
            getStartedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65)
            
        ])
    }
}
