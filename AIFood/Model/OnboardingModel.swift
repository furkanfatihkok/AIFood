//
//  OnboardingModel.swift
//  AIFood
//
//  Created by FFK on 11.12.2024.
//

import Foundation

struct OnboardingSlide {
    let title: String
    let description: String
    let imageName: String
}

struct OnboardingMockData {
    static func getSlides() -> [OnboardingSlide] {
        return [
            OnboardingSlide(title: "We serve incomparable delicacies", description: "All the best restaurants with their top menu waiting for you, they cant’t wait for your order!", imageName: "burger-1"),
            OnboardingSlide(title: "Fast and Reliable Delivery", description: "All the best restaurants with their top menu waiting for you, they cant’t wait for your order!", imageName: "burger-2"),
            OnboardingSlide(title: "Fresh Ingredients Everyday", description: "All the best restaurants with their top menu waiting for you, they cant’t wait for your order!", imageName: "burger-3")
        ]
    }
}
