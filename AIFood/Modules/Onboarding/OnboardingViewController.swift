//
//  OnboardingViewController.swift
//  AIFood
//
//  Created by FFK on 12.12.2024.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
    
    // MARK: - Properties
    private let slides: [OnboardingSlide] = OnboardingMockData.getSlides()
    private var currentPage = 0
    
    // MARK: - UI Elements
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .scrollableAxes
        scrollView.delegate = self
        return scrollView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setupSlides()
    }
    
    private func setupSlides() {
        for (index, slide) in slides.enumerated() {
            let slideView = SlideView()
            slideView.configure(with: slide, currentPage: index, totalPages: slides.count, isLastSlide: index == slides.count - 1)
            slideView.delegate = self
            scrollView.addSubview(slideView)
            
            slideView.snp.makeConstraints { make in
                make.width.equalTo(view.frame.width)
                make.height.equalTo(view.frame.height)
                make.leading.equalTo(CGFloat(index) * view.frame.width)
                make.top.bottom.equalToSuperview()
            }
        }
    }
}

// MARK: - UIScrollViewDelegate
extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.frame.width > 0, !scrollView.contentOffset.x.isNaN else {
            print("Invalid scrollView dimensions or contentOffset")
            return
        }

        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        currentPage = pageIndex
    }
}

// MARK: - SlideViewProtocol
extension OnboardingViewController: SlideViewProtocol {
    func didChangePage(to index: Int) {
        currentPage = index
        let xOffset = CGFloat(index) * scrollView.frame.width
        scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
    }
    
    func didTapSkipButton() {
        let previousIndex = currentPage - 1
        if previousIndex >= 0 {
            didChangePage(to: previousIndex)
        } else {
            print("Already on the first page")
        }
    }
    
    func didTapNextButton(at index: Int) {
        didChangePage(to: index + 1)
    }
    
    func didTapOkButton() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
}
