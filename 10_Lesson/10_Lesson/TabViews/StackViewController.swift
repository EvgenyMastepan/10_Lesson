//
//  StackViewController.swift
//  10_Lesson
//
//  Created by Evgeny Mastepan on 20.07.2025.
//

import UIKit

final class StackViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()
    private let countSelector = CountSelectorView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var currentCount = 5
    private var currentMemes: [RedditPost] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadMemes()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1)
        
        configureScrollView()
        configureContentStack()
        configureCountSelector()
        configureActivityIndicator()
        setupConstraints()
    }
    
    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
    }
    
    private func configureContentStack() {
        contentStackView.axis = .vertical
        contentStackView.spacing = 20
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)
    }
    
    private func configureCountSelector() {
        countSelector.delegate = self
        countSelector.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(countSelector)
    }
    
    private func configureActivityIndicator() {
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            countSelector.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            countSelector.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            countSelector.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            countSelector.heightAnchor.constraint(equalToConstant: 50),
            
            scrollView.topAnchor.constraint(equalTo: countSelector.bottomAnchor, constant: 12),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func loadMemes() {
        activityIndicator.startAnimating()
        clearContentStack()
        
        RedditLoader.shared.fetchMemes(count: currentCount) { [weak self] result in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.handleResult(result)
            }
        }
    }
    
    private func clearContentStack() {
        contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    private func handleResult(_ result: Result<[RedditPost], RedditError>) {
        switch result {
        case .success(let posts):
            displayPosts(posts)
        case .failure(let error):
            showError(error)
        }
    }
    
    private func displayPosts(_ posts: [RedditPost]) {
        currentMemes = posts
        contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        posts.forEach { post in
            let cell = MemeCell()
            cell.configure(with: post)
            
            // Добавляем Tag для идентификации ячейки
            cell.tag = posts.firstIndex(where: { $0.id == post.id }) ?? 0
            contentStackView.addArrangedSubview(cell)
            
            // Добавляем жест на всю ячейку
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleMemeTap(_:)))
            cell.addGestureRecognizer(tap)
        }
    }
    
    private func addTapGesture(to cell: MemeCell) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleMemeTap(_:)))
        cell.addGestureRecognizer(tap)
    }
    
   
    private func showError(_ error: RedditError) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func handleMemeTap(_ sender: UITapGestureRecognizer) {
        guard let cell = sender.view as? MemeCell else { return }
        let selectedMeme = currentMemes[cell.tag]
        
        // Отладочная информация! Можно удалять. Проверяем переход.
        print("Нажат мем с ID: \(selectedMeme.id)")
        
        guard let tabBar = tabBarController as? MainTabBarController,
              let detailVC = tabBar.viewControllers?[1] as? DetailViewController else {
            print("Ошибка: Не удалось получить DetailViewController")
            return
        }
        
        detailVC.currentMeme = selectedMeme
        tabBar.selectedIndex = 1
        print("Переход на DetailViewController выполнен")
    }
}

extension StackViewController: CountSelectorDelegate {
    func didSelectCount(_ count: Int) {
        currentCount = count
        loadMemes()
    }
}
