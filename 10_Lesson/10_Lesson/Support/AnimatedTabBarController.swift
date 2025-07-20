//
//  AnimatedTabBarController.swift
//  10_Lesson
//
//  Created by Evgeny Mastepan on 20.07.2025.
//

import UIKit

class AnimatedTabBarController: UITabBarController {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let tabIndex = tabBar.items?.firstIndex(of: item) else { return }
        
        let animation = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
            if let tabView = tabBar.subviews[tabIndex + 1] as? UIView {
                tabView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
        }
        animation.addAnimations({
            tabBar.subviews[tabIndex + 1].transform = .identity
        }, delayFactor: 0.3)
        animation.startAnimation()
    }
}
