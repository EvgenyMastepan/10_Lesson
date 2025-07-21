//
//  AnimatedTabBarController.swift
//  10_Lesson
//
//  Created by Evgeny Mastepan on 20.07.2025.
//

import UIKit

class AnimatedTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

extension AnimatedTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                         shouldSelect viewController: UIViewController) -> Bool {
        guard let viewControllers = viewControllers,
              let selectedIndex = viewControllers.firstIndex(of: viewController),
              let tabBarItems = tabBar.items,
              selectedIndex < tabBarItems.count else {
            return true
        }
        
        animateTabBarItem(at: selectedIndex)
        return true
    }
    
    private func animateTabBarItem(at index: Int) {
        let tabBarButtons = tabBar.subviews.compactMap { $0 as? UIControl }
        guard index < tabBarButtons.count else { return }
        
        let button = tabBarButtons[index]
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1.0, 1.2, 0.9, 1.1, 1.0]
        animation.duration = 0.5
        animation.calculationMode = .cubic
        
        button.layer.add(animation, forKey: "bounce")
    }
}
