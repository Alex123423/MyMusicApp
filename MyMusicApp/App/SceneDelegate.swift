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
        
        let rootVC = SignInViewController()
        let navigationController = NavBarController(rootViewController: rootVC)
        window?.rootViewController = navigationController
//        window?.rootViewController = SettingsViewController()

        window?.makeKeyAndVisible()
        
    }
}

//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//
//    var window: UIWindow?
//
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        let window = UIWindow(windowScene: windowScene)
//        self.window = window
//
//        if isOnboardingCompleted() {
//            let tabBarController = TabBarViewController()
//            window.rootViewController = tabBarController.createTabBar()
//        } else {
//            window.rootViewController = OnboardingViewController()
//        }
//
//        window.makeKeyAndVisible()
//    }
//
//    private func isOnboardingCompleted() -> Bool {
//        return UserDefaults.standard.bool(forKey: "isOnboardingCompleted")
//    }
//
//    private func createOnboarding() -> UIViewController {
//        let onboardingVC = OnboardingViewController()
//        let tabBarController = TabBarViewController()
//        onboardingVC.onCompletion = { [weak self, weak tabBarController] in
//            UserDefaults.standard.set(true, forKey: "isOnboardingCompleted")
//            self?.window?.rootViewController = tabBarController?.customTabBar
//        }
//        return UINavigationController(rootViewController: onboardingVC)
//    }
//}


