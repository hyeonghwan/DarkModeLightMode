//
//  DefaultStyle.swift
//  DarkModeLightMode
//
//  Created by 박형환 on 2022/09/22.
//

import Foundation
import UIKit


// enum Color 값 테스트
public enum DefaultStyle {
    
    public static let defaultStyle = DefaultStyle.Colors.self
    
    public enum Colors {

        public static let label: UIColor = {
            if #available(iOS 13.0, *) {
                return UIColor.label
            } else {
                return .black
            }
        }()

        static let systemRedColor: UIColor = UIColor.systemRed
        static let whiteColor: UIColor = UIColor.white
        static let black: UIColor = UIColor.black
        
        public static var tint: UIColor = {
            if #available(iOS 13, *) {
                return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                    if UITraitCollection.userInterfaceStyle == .dark {
                        /// Return the color for Dark Mode
                        return Colors.systemRedColor
                        
                    } else {
                        /// Return a fallback color for iOS 12 and lower.
                        return Colors.systemRedColor
                    }
                }
            }else {
                /// Return a fallback color for iOS 12 and lower.
                return Colors.whiteColor
            }
        }()
        
    }
}
