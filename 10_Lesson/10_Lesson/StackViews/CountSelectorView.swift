//
//  CountControlView.swift
//  10_Lesson
//
//  Created by Evgeny Mastepan on 20.07.2025.
//

import UIKit

protocol CountSelectorDelegate: AnyObject {
    func didSelectCount(_ count: Int)
}

final class CountSelectorView: UIView {
    weak var delegate: CountSelectorDelegate?
    
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .backgroundColor
        layer.cornerRadius = 8
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        (1...10).forEach { number in
            let button = UIButton(type: .system)
            button.setTitle("\(number)", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .buttonBackgroundColor
            button.layer.cornerRadius = 6
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text, let count = Int(title) else { return }
        delegate?.didSelectCount(count)
    }
}
