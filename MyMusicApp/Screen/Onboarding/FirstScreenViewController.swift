//
//  FirstScreenViewController.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 07.06.2023.
//

import UIKit

class FirstScreenViewController: UIViewController {
    
    let verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = OnboardingConstant.Image.firstOnboarding
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let getStartedButton = ReusableAuthButton(title: OnboardingConstant.Text.getStartedButton,
                                              target: self,
                                              action: #selector(buttonTapped))
    
    let firstTitle = CustomLabel().createCustomLabel(text: OnboardingConstant.Text.appUIKit,
                                                     textColor: CommonConstant.Color.customYellow ?? .white,
                                                     font: CommonConstant.FontSize.font14,
                                                     textAlignment: .left,
                                                     numberOfLines: 1)
    
    let secondTitle = CustomLabel().createCustomLabel(text: OnboardingConstant.Text.wellcome,
                                                      textColor: .white,
                                                      font: CommonConstant.FontSize.fontBold28,
                                                      textAlignment: .left,
                                                      numberOfLines: 2)
    
    let thirdTitle = CustomLabel().createCustomLabel(text: OnboardingConstant.Text.makeYourDesign,
                                                     textColor: .white,
                                                     font: CommonConstant.FontSize.font14,
                                                     textAlignment: .left,
                                                     numberOfLines: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = CommonConstant.Color.background
        
        setupHierarchy()
        setConstrains()
    }
    
    func setupHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(verticalStack)
        verticalStack.addArrangedSubview(firstTitle)
        verticalStack.addArrangedSubview(secondTitle)
        verticalStack.addArrangedSubview(thirdTitle)
        view.addSubview(getStartedButton)
    }
        
    
    func setConstrains() {
        
        NSLayoutConstraint.activate([
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            
            verticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            verticalStack.centerYAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.70),
            
            getStartedButton.heightAnchor.constraint(equalToConstant: 46),
            getStartedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CommonConstant.Padding.leading40),
            getStartedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: CommonConstant.Padding.trailing40),
            getStartedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65)
            
        ])
    }
    
    @objc func buttonTapped(){}
}
