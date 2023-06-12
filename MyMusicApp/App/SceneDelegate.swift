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
        window = UIWindow(windowScene: windowScene)
        let viewController = FirstScreenViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

