//
//  MemeSelectionDelegate.swift
//  10_Lesson
//
//  Created by Evgeny Mastepan on 20.07.2025.
//

import Foundation

protocol MemeSelectionDelegate: AnyObject {
    func didSelectMeme(_ meme: RedditPost)
}
