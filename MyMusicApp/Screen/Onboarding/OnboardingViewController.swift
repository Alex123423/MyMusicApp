//
//  OnboardingViewController.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 12.06.2023.
//

import UIKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        
    var pages = [FirstScreenViewController(),
                 SecondScreenViewController(),
                 ThirdScreenViewController(),
                 FourthScreenViewController()]
    
    let initialPage = 0
    
    let pageControl = UIPageControl()
        let pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                      navigationOrientation: .horizontal,
                                                      options: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        dataSource = self
        delegate = self
        
        configurePageControl()
        setViewControllers()
                self.addChild(pageViewController)
                self.view.addSubview(pageViewController.view)
        self.view.addSubview(pageControl)
        setConstrains()
    }
    
        func configurePageViewController() {
            pageViewController.dataSource = self
            pageViewController.view.frame = self.view.frame
            pageViewController.didMove(toParent: self)
            pageViewController.setViewControllers([pages[0]],
                                                  direction: .forward,
                                                  animated: true,
                                                  completion: nil)
        }
    
    func configurePageControl() {
        pageControl.frame = CGRect()
        pageControl.currentPageIndicatorTintColor = CommonConstant.Color.customYellow
        pageControl.pageIndicatorTintColor = CommonConstant.Color.lightGray
        pageControl.preferredIndicatorImage = OnboardingConstant.Image.activeDot
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
    }
    
    func setViewControllers() {
        setViewControllers([pages[initialPage]], direction: .reverse, animated: false, completion: nil)
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = pages.firstIndex(of: viewController) {
            if viewControllerIndex == 0 {
                // wrap to last page in array
                return nil
            } else {
                // go to previous page in array
                return pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
        
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = pages.firstIndex(of: viewController) {
            if viewControllerIndex < pages.count - 1 {
                // go to next page in array
                return pages[viewControllerIndex + 1]
            } else {
                // wrap to first page in array
                return nil
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {

        // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = pages.firstIndex(of: viewControllers[0]) {
                pageControl.currentPage = viewControllerIndex
            }
        }
    }
    
        func setConstrains() {
            pageControl.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
                pageControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
                pageControl.heightAnchor.constraint(equalToConstant: 20),
                pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
}

//class OnboardingViewController: UIPageViewController {
//
//    var currentPage = 0
//
//    let arrayViewControllers = [FirstScreenViewController(),
//                                SecondScreenViewController(),
//                                ThirdScreenViewController(),
//                                FourthScreenViewController()]
//
//    let pageViewController = UIPageViewController(transitionStyle: .scroll,
//                                                  navigationOrientation: .horizontal,
//                                                  options: nil)
//
//    let customPageControl = CustomPageControl(activeColor: CommonConstant.Color.lightGray ?? .red,
//                                              inactiveColor: CommonConstant.Color.lightGray ?? .white)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        configurePageViewController()
//        configurePageControl()
//        setupHierarchy()
//        setConstrains()
//    }
//
//    func configurePageViewController() {
//        pageViewController.dataSource = self
//        pageViewController.view.frame = self.view.frame
//        pageViewController.didMove(toParent: self)
//        pageViewController.setViewControllers([arrayViewControllers[0]],
//                                              direction: .forward,
//                                              animated: true,
//                                              completion: nil)
//    }
//
//    func configurePageControl() {
//        customPageControl.numberOfPages = arrayViewControllers.count
//        customPageControl.currentPage = self.currentPage
//        customPageControl.pageIndicatorTintColor = CommonConstant.Color.lightGray
//        customPageControl.currentPageIndicatorTintColor = CommonConstant.Color.customYellow
//        customPageControl.translatesAutoresizingMaskIntoConstraints = false
//    }
//
//    func setupHierarchy() {
//        self.addChild(pageViewController)
//        self.view.addSubview(pageViewController.view)
//        view.addSubview(customPageControl)
//    }
//
//    func setConstrains() {
//
//        NSLayoutConstraint.activate([
//            customPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            customPageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
//        ])
//    }
//}
//
//extension OnboardingViewController: UIPageViewControllerDataSource {
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//
//        guard let decreaseIndex = arrayViewControllers.lastIndex(of: viewController) else {
//            return nil
//        }
//
//        if decreaseIndex == 0 {
//            return nil
//        } else {
//            currentPage = decreaseIndex - 1
//            return arrayViewControllers[decreaseIndex - 1]
//        }
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//
//        guard let increaseIndex = arrayViewControllers.lastIndex(of: viewController) else {
//            return nil
//        }
//
//        if increaseIndex == arrayViewControllers.count - 1 {
//            return nil
//        } else {
//            currentPage = increaseIndex + 1
//            return arrayViewControllers[increaseIndex + 1]
//        }
//    }
//}
