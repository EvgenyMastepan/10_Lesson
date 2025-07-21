//
//  ViewController.swift
//  10_Lesson
//
//  Created by Evgeny Mastepan on 20.07.2025.
//

import UIKit

class ScrollViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alwaysBounceHorizontal = true
        $0.showsHorizontalScrollIndicator = true
        $0.alwaysBounceVertical = true
        $0.showsVerticalScrollIndicator = true
        $0.delegate = self
        return $0
    } (UIScrollView())
    
    private let contentView = UIView()
    
    private lazy var mapImage: UIImageView = {
        $0.image = UIImage(named: "map")
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        setupScrollView()
        setupZoom()
        
    }

    private func setupScrollView() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
        
        contentView.addSubview(mapImage)
        NSLayoutConstraint.activate([
            mapImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            mapImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mapImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mapImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            mapImage.widthAnchor.constraint(equalToConstant: 1757),
            mapImage.heightAnchor.constraint(equalToConstant: 1196),
        ])
        
    }
    
    private func setupZoom() {
            scrollView.minimumZoomScale = 1.0
            scrollView.maximumZoomScale = 4.0
    
            let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
            doubleTap.numberOfTapsRequired = 2
            mapImage.addGestureRecognizer(doubleTap)
        }
        
    @objc private func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale > scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            let targetScale = scrollView.maximumZoomScale / 2
            scrollView.setZoomScale(targetScale, animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() { //Выравниваем карту по центру при загрузке.
        super.viewDidLayoutSubviews()
        let offsetX = 1757 / 2 - (view.bounds.width / 2)
        scrollView.contentOffset = CGPoint(x: offsetX, y: 0)
    }
}

extension ScrollViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mapImage
    }
    
    // Отладочная информация! Можно убрать.
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        print("Текущий масштаб: \(scale)")
    }
}
