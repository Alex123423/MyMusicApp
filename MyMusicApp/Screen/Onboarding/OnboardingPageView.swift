//
//  OnboardingPageView.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 12.06.2023.
//

import UIKit

class OnboardingPageView: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Установите делегаты
        self.dataSource = self
        self.delegate = self
        
        // Создайте первый экран onboarding и установите его как начальный
        if let firstViewController = getViewController(atIndex: 0) {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = getIndex(for: viewController), index > 0 else {
            return nil
        }
        
        return getViewController(atIndex: index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = getIndex(for: viewController), index < 3 else {
            return nil
        }
        
        return getViewController(atIndex: index + 1)
    }
    
    // Возвращает индекс представления в UIPageViewController
    func getIndex(for viewController: UIViewController) -> Int? {
        // Здесь вам нужно реализовать логику получения индекса представления
        // в соответствии с вашими четырьмя экранами onboarding
        // Например, вы можете использовать идентификаторы представлений
        // или свойства на основе типа представления
        // Верните соответствующий индекс или nil, если не найден
        return nil
    }
    
    // Возвращает экран onboarding для заданного индекса
    func getViewController(atIndex index: Int) -> UIViewController? {
        // Здесь вам нужно создать экземпляр соответствующего представления
        // onboarding для заданного индекса и вернуть его
        // Например:
        // let onboardingViewController = OnboardingViewController(index: index)
        // return onboardingViewController
        
        return nil
    }
}
