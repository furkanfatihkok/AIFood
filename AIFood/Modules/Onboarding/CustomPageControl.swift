//
//  CustomPageControl.swift
//  AIFood
//
//  Created by FFK on 11.12.2024.
//

import UIKit

final class CustomPageControl: UIView {
    
    // MARK: - Properties
    private var numberOfPages: Int = 0
    private var currentPage: Int = 0 {
        didSet {
            updateDots()
        }
    }
    
    private var dotViews: [UIView] = []
    
    var activeDotColor: UIColor = .white
    var inactiveDotColor: UIColor = .gray
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    func configure(numberOfPages: Int) {
        self.numberOfPages = numberOfPages
        setupDots()
    }
    
    func setCurrentPage(_ page: Int) {
        guard page >= 0 && page < numberOfPages else { return }
        currentPage = page
    }
    
    private func setupDots() {
        dotViews.forEach { $0.removeFromSuperview() }
        dotViews = []
        
        for _ in 0..<numberOfPages {
            let dot = UIView()
            dot.layer.cornerRadius = 5
            dot.backgroundColor = inactiveDotColor
            dot.translatesAutoresizingMaskIntoConstraints = false
            addSubview(dot)
            dotViews.append(dot)
        }
        
        arrangeDots()
        updateDots()
    }
    
    private func arrangeDots() {
        for (index, dot) in dotViews.enumerated() {
            dot.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.width.height.equalTo(10)
                
                if index == 0 {
                    make.leading.equalToSuperview()
                } else {
                    make.leading.equalTo(dotViews[index - 1].snp.trailing).offset(10)
                }
                
                if index == dotViews.count - 1 {
                    make.trailing.equalToSuperview()
                }
            }
        }
    }
    
    private func updateDots() {
        for (index, dot) in dotViews.enumerated() {
            dot.backgroundColor = index == currentPage ? activeDotColor : inactiveDotColor
        }
    }
}

