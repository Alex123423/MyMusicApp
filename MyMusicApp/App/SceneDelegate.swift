//
//  SceneDelegate.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 06.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let rootVC = SignInViewController()
        let navigationController = NavBarController(rootViewController: rootVC)
        
        if UserDefaults.standard.hasOnboarded {
//            let tabBarController = TabBarViewController()
//            window.rootViewController = tabBarController.createTabBar()
            window.rootViewController = navigationController
        } else {
            window.rootViewController = OnboardingViewController()
        }
        window.makeKeyAndVisible()
    }
}


