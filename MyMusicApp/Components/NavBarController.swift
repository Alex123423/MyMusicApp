//
//  NavBarController.swift
//  MyMusicApp
//
//  Created by Vitali Martsinovich on 2023-06-14.
//

import UIKit

final class NavBarController: UINavigationController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        config()
    }

    private func config() {
        navigationBar.backgroundColor = .clear
        navigationBar.backIndicatorImage = CommonConstant.Icon.backArrow?.withRenderingMode(.alwaysOriginal)
        navigationBar.backIndicatorTransitionMaskImage = CommonConstant.Icon.backArrow
        navigationBar.tintColor = .white
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationBar.topItem?.backBarButtonItem = backButton
        
        let titleFont = CommonConstant.FontSize.fontBold18
        let titleColor = UIColor.white
        let attributes: [NSAttributedString.Key: Any] = [
            .font: titleFont as Any,
            .foregroundColor: titleColor
        ]
        navigationBar.titleTextAttributes = attributes
    }
}
