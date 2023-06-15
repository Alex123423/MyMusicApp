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
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = OnboardingConstant.Image.secondOnboarding
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let getStartedButton = ReusableAuthButton(title: OnboardingConstant.Text.getStartedButton,
                                              target: self,
                                              action: #selector(buttonTapped))
    
    let firstTitle = CustomLabel().createCustomLabel(text: OnboardingConstant.Text.appUIKit,
                                                     textColor: .maCustomYellow ?? .white,
                                                     font: CommonConstant.FontSize.font14,
                                                     textAlignment: .center,
                                                     numberOfLines: 1)
    
    let secondTitle = CustomLabel().createCustomLabel(text: OnboardingConstant.Text.wellcome,
                                                      textColor: .white,
                                                      font: CommonConstant.FontSize.fontBold28,
                                                      textAlignment: .center,
                                                      numberOfLines: 2)
    
    let thirdTitle = CustomLabel().createCustomLabel(text: OnboardingConstant.Text.makeYourDesign,
                                                     textColor: .white,
                                                     font: CommonConstant.FontSize.font14,
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
            getStartedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            getStartedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            getStartedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65)
        ])
    }
    
    @objc func buttonTapped() {
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }
}
