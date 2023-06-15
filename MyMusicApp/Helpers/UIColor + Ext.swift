//
//  UIColor + Ext.swift
//  MyMusicApp
//
//  Created by Dmitry Medvedev on 13.06.2023.
//

import UIKit

extension UIColor {
    // Basic colors:
    static let maBackground = UIColor(named: "background") ?? UIColor.black
    static let maButtonText = UIColor(named: "buttonText") ?? UIColor.darkText
    static let maCustomYellow = UIColor(named: "customYellow") ?? UIColor.yellow
    static let maDarkGray = UIColor(named: "darkGray") ?? UIColor.darkGray
    static let maLightGray = UIColor(named: "lightGray") ?? UIColor.lightGray
    static let maNotificationTime = UIColor(named: "notificationTime") ?? UIColor.systemBlue
    static let maPlaylistBackground = UIColor(named: "playlistBackground") ?? UIColor.systemFill
    static let maTextFieldBorder = UIColor(named: "textFieldBorder") ?? UIColor.lightGray
    static let maCollectionTextColor = UIColor(named: "collectionTextColor") ?? UIColor.lightGray
    static let maSecondColorTableView = UIColor(named: "secondColorTableView") ?? UIColor.lightGray
}
