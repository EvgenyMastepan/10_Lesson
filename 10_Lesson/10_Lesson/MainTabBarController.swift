//
//  MainTabBarController.swift
//  10_Lesson
//
//  Created by Evgeny Mastepan on 20.07.2025.
//

import UIKit

class MainTabBarController: AnimatedTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupTabBarController()
    }
    
    private func setupViewControllers() {
        let homeVC = StackViewController()
        homeVC.view.backgroundColor = .black
        homeVC.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "house.fill"), tag: 0)
        
        let scrollVC = DetailViewController()
        scrollVC.view.backgroundColor = .systemBlue
        scrollVC.tabBarItem = UITabBarItem(title: "Delegate", image: UIImage(systemName: "arrowshape.left.arrowshape.right.fill"), tag: 1)
        
        let delegateVC = ScrollViewController()
        delegateVC.view.backgroundColor = .systemGreen
        delegateVC.tabBarItem = UITabBarItem(title: "Scroll", image: UIImage(systemName: "scroll.fill"), tag: 2)
        
        viewControllers = [homeVC, scrollVC, delegateVC]
    }
    
    private func setupTabBarController() {
        tabBar.layer.cornerRadius = 20
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -3)
        tabBar.layer.shadowRadius = 5
        tabBar.clipsToBounds = false
        
        tabBar.tintColor = .systemPurple
        tabBar.unselectedItemTintColor = .gray
        tabBar.backgroundColor = .white
    }
}
