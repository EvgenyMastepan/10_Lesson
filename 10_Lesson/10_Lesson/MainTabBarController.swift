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
        setupTabBarAppearance()
        setupViewControllers()
        setupTabBarController()
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.selected.iconColor = .systemPurple
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemPurple]
        //для старой версии
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    private func setupViewControllers() {
        let homeVC = StackViewController()
        homeVC.view.backgroundColor = .black
        homeVC.tabBarItem = UITabBarItem(
            title: "Главная",
            image: UIImage(systemName: "house.fill"),
            tag: 0
        )
        
        let detailVC = DetailViewController()
        detailVC.view.backgroundColor = .black
        detailVC.tabBarItem = UITabBarItem(
            title: "Delegate",
            image: UIImage(systemName: "arrowshape.left.arrowshape.right.fill"),
            tag: 1
        )
        
        let scrollVC = ScrollViewController()
        scrollVC.view.backgroundColor = .black
        scrollVC.tabBarItem = UITabBarItem(
            title: "Scroll",
            image: UIImage(systemName: "scroll.fill"),
            tag: 2
        )
        
        viewControllers = [homeVC, detailVC, scrollVC]
    }
    
    private func setupTabBarController() {
        tabBar.layer.cornerRadius = 20
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.shadowColor = UIColor.white.cgColor
        tabBar.layer.shadowOpacity = 0.3
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -3)
        tabBar.layer.shadowRadius = 8
        tabBar.clipsToBounds = false
        
        
        tabBar.tintColor = .systemPurple
        tabBar.unselectedItemTintColor = .gray
        tabBar.backgroundColor = .black
        tabBar.barTintColor = .black
    }
}
