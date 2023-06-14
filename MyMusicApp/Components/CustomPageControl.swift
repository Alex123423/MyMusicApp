//
//  CustomPageControl.swift
//  MyMusicApp
//
//  Created by Alexey Davidenko on 12.06.2023.
//

import UIKit

class CustomPageControl: UIPageControl {

    private let activeDotColor: UIColor
    private let inactiveDotColor: UIColor

    init(activeColor: UIColor, inactiveColor: UIColor) {
        self.activeDotColor = activeColor
        self.inactiveDotColor = inactiveColor

        super.init(frame: .zero)

        // Customize the appearance
        pageIndicatorTintColor = inactiveDotColor
        currentPageIndicatorTintColor = activeDotColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var numberOfPages: Int {
        didSet {

            updateDotsAppearance()
        }
    }

    override var currentPage: Int {
        didSet {

            updateDotsAppearance()
        }
    }

    private func updateDotsAppearance() {
        for (index, dotView) in self.subviews.enumerated() {
            if let dotImageView = dotView as? UIImageView {
                dotImageView.image = dotImage(with: index)
            } else {
                let dotImageView = UIImageView(image: dotImage(with: index))
                dotImageView.frame = dotView.frame
                dotImageView.contentMode = .center
                dotImageView.isUserInteractionEnabled = false
                dotView.addSubview(dotImageView)
                dotView.clipsToBounds = false
            }
        }
    }

    private func dotImage(with index: Int) -> UIImage? {
        // Customize the dot image based on the current page and index
        // You can use different images for active and inactive dots
        if index == currentPage {
            return OnboardingConstant.Image.activeDot
        } else {
            return OnboardingConstant.Image.inactiveDo
        }
    }


}
