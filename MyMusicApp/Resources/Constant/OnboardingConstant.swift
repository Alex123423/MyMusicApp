//
//  Onboarding.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 11.06.2023.
//

import UIKit


enum OnboardingConstant {
    
    enum Image {
        static let background = UIImage(named: "background")
        static let firstOnboarding = UIImage(named: "firstOnboarding")
        static let secondOnboarding = UIImage(named: "secondOnboarding")
        static let thirdOnboarding = UIImage(named: "thirdOnboarding")
        static let fourthOnboarding = UIImage(named: "fourthOnboarding")
        static let activeDot = UIImage(named: "activeDot")
        static let inactiveDo = UIImage(named: "inactiveDot")
    }
    
    enum Text {
        //Title
        static let wellcome = "WELCOME TO\nMUSIC APP"
        static let music = "MUSIC"
        
        //Label
        static let appUIKit = "APP UI KIT"
        static let makeYourDesign = "Make your design workflow easier and\nsave your time"
        
        //Button
        static let getStartedButton = "GET STARTED"
    }
}
