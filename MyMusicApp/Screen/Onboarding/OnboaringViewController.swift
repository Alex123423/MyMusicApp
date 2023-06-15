//
//  OnboaringViewController.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 07.06.2023.
//

import UIKit

class OnboaringViewController: UIViewController {
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = OnboardingConstant.Image.firstOnboarding
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    var firstTitle = CustomLabel().createCustomLabel(text: OnboardingConstant.Text.appUIKit,
                                                     textColor: CommonConstant.Color.customYellow ?? .white,
                                                     font: CommonConstant.FontSize.font14,
                                                     textAlignment: .left,
                                                     numberOfLines: 1)
    
    var secondTitle = CustomLabel().createCustomLabel(text: OnboardingConstant.Text.wellcome,
                                                     textColor: .white,
                                                     font: CommonConstant.FontSize.fontBold28,
                                                     textAlignment: .left,
                                                     numberOfLines: 2)
    
    var thirdTitle = CustomLabel().createCustomLabel(text: OnboardingConstant.Text.makeYourDesign,
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
        view.addSubview(firstTitle)
        view.addSubview(secondTitle)
        view.addSubview(thirdTitle)
    }
        
    
    func setConstrains() {
        
        NSLayoutConstraint.activate([
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            
            firstTitle.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 50),
            firstTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            secondTitle.topAnchor.constraint(equalTo: firstTitle.bottomAnchor, constant: 10),
            secondTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            thirdTitle.topAnchor.constraint(equalTo: secondTitle.bottomAnchor, constant: 10),
            thirdTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        ])
    }
}
