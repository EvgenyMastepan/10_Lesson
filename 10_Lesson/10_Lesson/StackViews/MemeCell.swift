//
//  MemeView.swift
//  10_Lesson
//
//  Created by Evgeny Mastepan on 20.07.2025.
//

import UIKit

final class MemeCell: UIView {
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let metadataLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with post: RedditPost) {
        titleLabel.text = post.title
        loadImage(from: post.imageUrl)
        
        let date = Date(timeIntervalSince1970: post.created_utc)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        metadataLabel.text = "↑\(post.ups) 💬\(post.num_comments) 👤\(post.author) 📅\(formatter.string(from: date))"
    }
    
    private func setupUI() {
        backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        layer.cornerRadius = 12
        layer.masksToBounds = true
        
        // Настройка изображения
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1)
        
        // Настройка текста
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        metadataLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        metadataLabel.textColor = .lightGray
        
        // Настройка стека
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(metadataLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 250),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    private func setupTap() {
        isUserInteractionEnabled = true // Важно!
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCell))
        addGestureRecognizer(tap)
    }
    
    @objc private func didTapCell() {
        // Обработка нажатия будет в контроллере
    }
    
    private func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }.resume()
    }
}
