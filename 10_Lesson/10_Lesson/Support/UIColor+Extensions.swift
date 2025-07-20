//
//  UIColor+Extensions.swift
//  10_Lesson
//
//  Created by Evgeny Mastepan on 20.07.2025.
//

import UIKit

extension UIColor {
    static let darkBackground = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
    static let darkGray = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
}

extension Notification.Name {
    static let artworksCountDidChange = Notification.Name("artworksCountDidChange")
}
