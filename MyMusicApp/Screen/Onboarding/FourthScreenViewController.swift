//
//  FourthScreenViewController.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 12.06.2023.
//

import UIKit

class FourthScreenViewController: UIViewController {
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = OnboardingConstant.Image.fourthOnboarding
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let getStartedButton = ReusableAuthButton(title: OnboardingConstant.Text.getStartedButton,
                                              target: self,
                                              action: #selector(buttonTapped))
    
    let firstTitle = CustomLabel().createCustomLabel(text: OnboardingConstant.Text.music,
                                                     textColor: CommonConstant.Color.white,
                                                     font: CommonConstant.FontSize.fontBold64,
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
            getStartedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CommonConstant.Padding.leading40),
            getStartedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CommonConstant.Padding.trailing40),
            getStartedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65)
            
        ])
    }
    
    @objc func buttonTapped(){}
}
