//
//  DetailViewController.swift
//  10_Lesson
//
//  Created by Evgeny Mastepan on 20.07.2025.
//

import UIKit

class DetailViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let metadataStack = UIStackView()
    
    var currentMeme: RedditPost? {
        didSet {
            guard isViewLoaded else { return }
            configureViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureViews()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1)
        
        // Настройка скролла
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Настройка стека
        contentStack.axis = .vertical
        contentStack.spacing = 20
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStack)
        
        // Настройка изображения
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1)
        
        // Настройка заголовка
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        // Настройка данных
        metadataStack.axis = .vertical
        metadataStack.spacing = 8
        
        contentStack.addArrangedSubview(imageView)
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(metadataStack)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
            
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
    
    func configureViews() {
        guard let meme = currentMeme else {
            imageView.image = nil
            titleLabel.text = "Мем не загружен"
            metadataStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
            return
        }
        
        titleLabel.text = meme.title
        metadataStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Добавляем данные
        addMetadataItem(icon: "arrow.up", text: "\(meme.ups) лайков")
        addMetadataItem(icon: "bubble.left", text: "\(meme.num_comments) комментариев")
        addMetadataItem(icon: "person", text: meme.author)
        
        let date = Date(timeIntervalSince1970: meme.created_utc)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        addMetadataItem(icon: "calendar", text: formatter.string(from: date))
        
        // Загрузка изображения
        if let urlString = meme.imageUrl?.replacingOccurrences(of: "&amp;", with: "&"),
           let url = URL(string: urlString) {
            loadImage(from: url)
        }
    }
    
    private func addMetadataItem(icon: String, text: String) {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        
        let iconView = UIImageView(image: UIImage(systemName: icon))
        iconView.tintColor = .lightGray
        iconView.contentMode = .scaleAspectFit
        iconView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        let label = UILabel()
        label.text = text
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        
        stack.addArrangedSubview(iconView)
        stack.addArrangedSubview(label)
        metadataStack.addArrangedSubview(stack)
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }.resume()
    }
}
