//
//  Constants.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 06.06.2023.
//

import UIKit


enum СommonConstants {
    
    //MARK: - Constants
        enum FontSize {
            static let font10 = UIFont.systemFont(ofSize: 10)
            static let font12 = UIFont.systemFont(ofSize: 12)
            static let font14 = UIFont.systemFont(ofSize: 14)
            static let font16 = UIFont.systemFont(ofSize: 16)
            static let font18 = UIFont.systemFont(ofSize: 18)
            static let font22 = UIFont.systemFont(ofSize: 22)
            
            static let fontBold12 = UIFont.boldSystemFont(ofSize: 12)
            static let fontBold18 = UIFont.boldSystemFont(ofSize: 18)
            static let fontBold22 = UIFont.boldSystemFont(ofSize: 22)
            static let fontBold28 = UIFont.boldSystemFont(ofSize: 28)
            static let fontBold36 = UIFont.boldSystemFont(ofSize: 36)
            static let fontBold48 = UIFont.boldSystemFont(ofSize: 48)
            static let fontBold64 = UIFont.boldSystemFont(ofSize: 64)
        }
        
        enum Padding {
            static let between10 = 18
            static let leading24 = 24
            static let trailing24 = 24
            static let leading40 = 40
            static let trailing40 = 40
        }
        
        enum Color {
            static let background = UIColor(named: "background")
            static let playlistBackground = UIColor(named: "playlistBackground")
            static let customYellow = UIColor(named: "customYellow")
            static let darkGray = UIColor(named: "darkGray")
            static let lightGray = UIColor(named: "lightGray")
            static let notificationTime = UIColor(named: "notificationTime")
            static let white = UIColor.white
        }
    
        enum Radius {
            static let radius8 = 8
        }
    }
