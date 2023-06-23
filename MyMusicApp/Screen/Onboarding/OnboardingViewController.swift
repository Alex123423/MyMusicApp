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
    
    let pageControl = UIPageControl()
    
    let pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                  navigationOrientation: .horizontal,
                                                  options: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        configurePageViewController()
        configurePageControl()
    
        setupHierarchy()
        setConstrains()
    }
    
    func configurePageViewController() {
        pageViewController.dataSource = self
        pageViewController.view.frame = self.view.frame
        pageViewController.didMove(toParent: self)
        pageViewController.setViewControllers([pages[0]],
                                              direction: .forward,
                                              animated: false,
                                              completion: nil)
    }
    
    func configurePageControl() {
        pageControl.frame = CGRect()
        pageControl.currentPageIndicatorTintColor = .maCustomYellow
        pageControl.pageIndicatorTintColor = .maLightGray
        pageControl.preferredIndicatorImage = OnboardingConstant.Image.activeDot
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = pages.firstIndex(of: viewController) {
            if viewControllerIndex < pages.count - 1 {
                // go to next page in array
                pageControl.currentPage = viewControllerIndex
                return pages[viewControllerIndex + 1]
            } else {
                // wrap to first page in array
                pageControl.currentPage = viewControllerIndex
                return nil
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = pages.firstIndex(of: viewController) {
            if viewControllerIndex == 0 {
                // wrap to last page in array
                pageControl.currentPage = viewControllerIndex
                return nil
            } else {
                // go to previous page in array
                pageControl.currentPage = viewControllerIndex
                return pages[viewControllerIndex - 1]
            }
            
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = pages.firstIndex(of: viewControllers[0]) {
                pageControl.currentPage = viewControllerIndex
            }
        }
    }
    
    func setupHierarchy() {
        self.addChild(pageViewController)
        self.view.addSubview(pageViewController.view)
        self.view.addSubview(pageControl)
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
