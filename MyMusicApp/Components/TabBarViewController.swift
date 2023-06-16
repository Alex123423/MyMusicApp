//
//  TabBarViewController.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 13.06.2023.
//

import UIKit

//class TabBarViewController: UITabBarController {
//
//    func homeController() -> UINavigationController {
//        let navigationVC = UINavigationController(rootViewController: HomeViewController())
//        navigationVC.tabBarItem = UITabBarItem(title: TabBarConstant.Text.home,
//                                               image: TabBarConstant.Symbols.home,
//                                               tag: 0)
//        return navigationVC
//    }
//
//    func exploreControler() -> UINavigationController {
//        let navigationVC = UINavigationController(rootViewController: ExploreMainViewController())
//        navigationVC.tabBarItem = UITabBarItem(title: TabBarConstant.Text.explore,
//                                               image: TabBarConstant.Symbols.explore,
//                                               tag: 1)
//        return navigationVC
//    }
//
//    func collectionController() -> UINavigationController {
//        let navigationVC = UINavigationController(rootViewController: MyCollectionViewController())
//        navigationVC.tabBarItem = UITabBarItem(title: TabBarConstant.Text.favorite,
//                                               image: TabBarConstant.Symbols.favorite,
//                                               tag: 2)
//        return navigationVC
//    }
//
//    func accountControler() -> UINavigationController {
//        let navigationVC = UINavigationController(rootViewController: AccountMainViewController())
//        navigationVC.tabBarItem = UITabBarItem(title: TabBarConstant.Text.account,
//                                               image: TabBarConstant.Symbols.account,
//                                               tag: 3)
//        return navigationVC
//    }
//
//
//    func createTabBar() -> UITabBarController {
//        let tabBar = UITabBarController()
//        tabBar.viewControllers = [homeController(), exploreControler(), collectionController(), accountControler()]
//        tabBar.tabBar.layer.cornerRadius = 0
//        tabBar.tabBar.layer.borderWidth = 0
//        tabBar.tabBar.tintColor = CommonConstant.Color.customYellow
//        tabBar.tabBar.unselectedItemTintColor = CommonConstant.Color.lightGray
//        tabBar.tabBar.layer.masksToBounds = true
//        return tabBar
//    }
//
//    var customTabBar: UITabBarController {
//        return createTabBar()
//    }
//}

class TabBarViewController: UITabBarController {
    
    func homeController() -> UIViewController {
        let vc = HomeScreenViewController()
        //let navigationVC = NavBarController(rootViewController: HomeScreenViewController())
        vc.tabBarItem = UITabBarItem(title: TabBarConstant.Text.home,
                                     image: TabBarConstant.Symbols.home,
                                     tag: 0)
        return vc
    }
    
    func exploreControler() -> NavBarController {
        let navigationVC = NavBarController(rootViewController: ExploreMainViewController())
        navigationVC.tabBarItem = UITabBarItem(title: TabBarConstant.Text.explore,
                                               image: TabBarConstant.Symbols.explore,
                                               tag: 1)
        return navigationVC
    }
    
    func collectionController() -> NavBarController {
        let navigationVC = NavBarController(rootViewController: MyCollectionViewController())
        navigationVC.tabBarItem = UITabBarItem(title: TabBarConstant.Text.favorite,
                                               image: TabBarConstant.Symbols.favorite,
                                               tag: 2)
        return navigationVC
    }
    
    func accountControler() -> NavBarController {
        let navigationVC = NavBarController(rootViewController: AccountMainViewController())
        navigationVC.tabBarItem = UITabBarItem(title: TabBarConstant.Text.account,
                                               image: TabBarConstant.Symbols.account,
                                               tag: 3)
        return navigationVC
    }
    
    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.viewControllers = [homeController(), exploreControler(), collectionController(), accountControler()]
        tabBar.tabBar.layer.cornerRadius = 0
        tabBar.tabBar.layer.borderWidth = 0
        tabBar.tabBar.tintColor = .maCustomYellow
        tabBar.tabBar.unselectedItemTintColor = .maLightGray
        tabBar.tabBar.layer.masksToBounds = true
        return tabBar
    }
    
    var customTabBar: UITabBarController {
        return createTabBar()
    }
}
