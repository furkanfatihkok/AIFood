//
//  Constants.swift
//  AIFood
//
//  Created by FFK on 11.12.2024.
//

import UIKit

struct Constants {
    struct Colors {
        static let primaryColor = UIColor(red: 254/255, green: 140/255, blue: 0/255, alpha: 1.0)
    }
    
    struct Fonts {
        static func interRegular(size: CGFloat) -> UIFont? {
            return UIFont(name: "Inter-Regular", size: size)
        }
        
        static func interBold(size: CGFloat) -> UIFont? {
            return UIFont(name: "Inter-Bold", size: size)
        }
        
        static func interSemiBold(size: CGFloat) -> UIFont? {
            return UIFont(name: "Inter-SemiBold", size: size)
        }
        
        static func interLight(size: CGFloat) -> UIFont? {
            return UIFont(name: "Inter-Light", size: size)
        }
    }
}
