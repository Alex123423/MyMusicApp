//
//  SecondScreenViewController.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 12.06.2023.
//

import UIKit

class SecondScreenViewController: UIViewController {
    
    let verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
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
        image.image = OnboardingConstant.Image.secondOnboarding
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    var firstTitle = CustomLabel().createCustomLabel(text: OnboardingConstant.Text.appUIKit,
                                                     textColor: СommonConstant.Color.customYellow ?? .white,
                                                     font: СommonConstant.FontSize.font14,
                                                     textAlignment: .center,
                                                     numberOfLines: 1)
    
    var secondTitle = CustomLabel().createCustomLabel(text: OnboardingConstant.Text.wellcome,
                                                     textColor: .white,
                                                     font: СommonConstant.FontSize.fontBold28,
                                                     textAlignment: .center,
                                                     numberOfLines: 2)
    
    var thirdTitle = CustomLabel().createCustomLabel(text: OnboardingConstant.Text.makeYourDesign,
                                                      textColor: .white,
                                                      font: СommonConstant.FontSize.font14,
                                                      textAlignment: .center,
                                                      numberOfLines: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            getStartedButton.heightAnchor.constraint(equalToConstant: 46),
            getStartedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: СommonConstant.Padding.leading40),
            getStartedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: СommonConstant.Padding.trailing40),
            getStartedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65)
            
        ])
    }
}
