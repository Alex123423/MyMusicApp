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
        image.image = OnboardingConstant.Image.firstOnboarding
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    var firstTitle = CustomLabel().createCustomLabel(text: OnboardingConstant.Text.appUIKit,
                                                     textColor: СommonConstant.Color.customYellow ?? .white,
                                                     font: СommonConstant.FontSize.font14,
                                                     textAlignment: .left,
                                                     numberOfLines: 1)
    
    var secondTitle = CustomLabel().createCustomLabel(text: OnboardingConstant.Text.wellcome,
                                                     textColor: .white,
                                                     font: СommonConstant.FontSize.fontBold28,
                                                     textAlignment: .left,
                                                     numberOfLines: 2)
    
    var thirdTitle = CustomLabel().createCustomLabel(text: OnboardingConstant.Text.makeYourDesign,
                                                      textColor: .white,
                                                      font: СommonConstant.FontSize.font14,
                                                      textAlignment: .left,
                                                      numberOfLines: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = СommonConstant.Color.background
        
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
            getStartedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: СommonConstant.Padding.leading40),
            getStartedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: СommonConstant.Padding.trailing40),
            getStartedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65)
            
        ])
    }
}
