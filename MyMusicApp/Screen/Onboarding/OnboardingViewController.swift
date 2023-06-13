//
//  OnboardingViewController.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 12.06.2023.
//

import UIKit

class OnboardingViewController: UIPageViewController {

    let arrayViewControllers = [FirstScreenViewController(),
                                SecondScreenViewController(),
                                ThirdScreenViewController(),
                                FourthScreenViewController()]
    
    let pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                  navigationOrientation: .horizontal,
                                                  options: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePageViewController()
        self.addChild(pageViewController)
        self.view.addSubview(pageViewController.view)
        
        let customPageControl = CustomPageControl(activeColor: .red, inactiveColor: .gray)
        customPageControl.numberOfPages = arrayViewControllers.count
        customPageControl.currentPage = 0
        customPageControl.pageIndicatorTintColor = CommonConstant.Color.lightGray
        customPageControl.currentPageIndicatorTintColor = CommonConstant.Color.customYellow
        customPageControl.translatesAutoresizingMaskIntoConstraints = false

        // Add the customPageControl to your view hierarchy
        view.addSubview(customPageControl)
        
        NSLayoutConstraint.activate([
            customPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customPageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])

    }
    
    func configurePageViewController() {
        pageViewController.dataSource = self
        pageViewController.view.frame = self.view.frame
        pageViewController.didMove(toParent: self)
        pageViewController.setViewControllers([arrayViewControllers[0]],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
    }
}

extension OnboardingViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let decreaseIndex = arrayViewControllers.lastIndex(of: viewController) else {
            return nil
        }
        
        if decreaseIndex == 0 {
            print(decreaseIndex)
            return nil
        } else {
            print(decreaseIndex)
            return arrayViewControllers[decreaseIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let increaseIndex = arrayViewControllers.lastIndex(of: viewController) else {
            return nil
        }
        
        if increaseIndex == arrayViewControllers.count - 1 {
            print(increaseIndex)
            return nil
        } else {
            print(increaseIndex)
            return arrayViewControllers[increaseIndex + 1]
        }
    }
}
