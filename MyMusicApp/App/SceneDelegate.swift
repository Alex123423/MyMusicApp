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
        let songVC = SongPlayer()
        
        let rootVC = SignInViewController()
        let navigationController = NavBarController(rootViewController: songVC)
        window?.rootViewController = navigationController
//        window?.rootViewController = SettingsViewController()

        window?.makeKeyAndVisible()
        
    }
}
