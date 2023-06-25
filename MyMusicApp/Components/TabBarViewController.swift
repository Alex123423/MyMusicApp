//
//  TabBarViewController.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 13.06.2023.
//

import UIKit

protocol TabBarViewControllerDelegate: AnyObject {
    func minimazedTopAnchorConstraintFunc()
    func maximizeTopAnchorConstraintFunc(model: Album?)
}

class TabBarViewController: UITabBarController {
    
    let trackDetailView = NewTestVC()
    let tabBarVC = UITabBarController()
    
    var minimazedTopAnchorConstraint : NSLayoutConstraint!
    var maximizedTopAnchorConstraint : NSLayoutConstraint!
    var bottomAnchorConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trackDetailView.tabBarDelegate = self
        tabBarConfigure()
    }
    
    func homeController() -> UIViewController {
        let vc = HomeScreenViewController()
        vc.newScreenDelegate = self
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
        let navigationVC = NavBarController(rootViewController: FavouritesViewController())
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
        tabBarVC.viewControllers = [homeController(), exploreControler(), collectionController(), accountControler()]
        tabBarVC.tabBar.layer.cornerRadius = 0
        tabBarVC.tabBar.layer.borderWidth = 0
        tabBarVC.tabBar.tintColor = .maCustomYellow
        tabBarVC.tabBar.backgroundColor = .maBackground
        tabBarVC.tabBar.unselectedItemTintColor = .maLightGray
        tabBarVC.tabBar.layer.masksToBounds = true
        return tabBarVC
    }
    
    func tabBarConfigure(){
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        tabBarVC.view.insertSubview(trackDetailView, belowSubview: tabBarVC.tabBar)
        
        maximizedTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: tabBarVC.view.topAnchor, constant:  tabBarVC.view.frame.height)
        minimazedTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: tabBarVC.tabBar.topAnchor, constant: -70)
        bottomAnchorConstraint = trackDetailView.bottomAnchor.constraint(equalTo: tabBarVC.view.bottomAnchor, constant: tabBarVC.view.frame.height)
        
        maximizedTopAnchorConstraint.isActive = true
        bottomAnchorConstraint.isActive = true
        
        trackDetailView.trailingAnchor.constraint(equalTo: tabBarVC.tabBar.trailingAnchor).isActive = true
        trackDetailView.leadingAnchor.constraint(equalTo: tabBarVC.tabBar.leadingAnchor).isActive = true
    }
    
    var customTabBar: UITabBarController {
        return createTabBar()
    }
}

extension TabBarViewController: TabBarViewControllerDelegate {
    
    func maximizeTopAnchorConstraintFunc(model: Album?) {

        minimazedTopAnchorConstraint.isActive = false
        maximizedTopAnchorConstraint.isActive = true
        maximizedTopAnchorConstraint.constant = 0
        bottomAnchorConstraint.constant = 0
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
            self.tabBarVC.view.layoutIfNeeded()
            self.tabBarVC.tabBar.alpha = 0
            self.trackDetailView.miniView.alpha = 0
        })
        guard let model = model else { return }
        trackDetailView.configureSongPlayerView(sender: model)
    }
    
    
    func minimazedTopAnchorConstraintFunc() {
        
        maximizedTopAnchorConstraint.isActive = false
        bottomAnchorConstraint.constant = tabBarVC.view.frame.height
        minimazedTopAnchorConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
            self.tabBarVC.view.layoutIfNeeded()
            self.tabBarVC.tabBar.alpha = 1
            self.trackDetailView.miniView.alpha = 1
        })
    }
    
}
