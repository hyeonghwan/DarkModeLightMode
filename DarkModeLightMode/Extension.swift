//
//  Extension.swift
//  DarkModeLightMode
//
//  Created by 박형환 on 2022/09/21.
//

import Foundation
import UIKit


infix operator |: AdditionPrecedence

extension UIColor {
        /// Easily define two colors for both light and dark mode.
        /// - Parameters:
        ///   - lightMode: The color to use in light mode.
        ///   - darkMode: The color to use in dark mode.
        /// - Returns: A dynamic color that uses both given colors respectively for the given user interface style.
        static func | (lightMode: UIColor, darkMode: UIColor) -> UIColor {
            guard #available(iOS 13.0, *) else { return lightMode }
            return UIColor { (traitCollection) -> UIColor in
                return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
            }
        }
}


extension UIImage {
    /// Inverts the colors from the current image. Black turns white, white turns black etc.
    func invertedColors() -> UIImage? {

        guard let ciImage = CIImage(image: self) ?? ciImage,
              let filter = CIFilter(name: "CIColorInvert")
        else { return nil }
      
        filter.setValue(ciImage, forKey: kCIInputImageKey)
    
        guard let outputImage = filter.outputImage else {print("fail"); return nil }
    
        return UIImage(ciImage: outputImage)
    }
    
    /// 이미지 사이즈 조정 함수
    /// - Parameter size: 이미지 사이즈
    /// - Returns: 이미지
    func resized(_ size: CGSize) -> UIImage{
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}


//라벨 환경설정
extension UILabel {
    // 타이틀 라벨 설정
    func settingTitleLabel() {
         self.backgroundColor = .clear
        self.textColor = UIColor.black | UIColor.white
         self.font = UIFont(name: "NanumGothicExtraBold", size: 30)
         self.numberOfLines = 0
         self.lineBreakMode = .byWordWrapping
         self.textAlignment = .center
        let paragraphStyle = NSMutableParagraphStyle()
         paragraphStyle.lineHeightMultiple = 1.18
         self.attributedText =
         NSMutableAttributedString(
             string:"사용하실 모드를 \n  선택해주세요!", attributes: [NSAttributedString.Key.kern: 0.15, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    // 라벨 설정
    func settingRedLabel() {
        self.frame = CGRect(x: 0, y: 0, width: 216, height: 41)
        self.backgroundColor = .clear
        self.textColor = DefaultStyle.defaultStyle.tint
        
        self.font = UIFont(name: "NanumGothicBold", size: 16)
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.13
        self.textAlignment = .center
        self.attributedText = NSMutableAttributedString(string: "화면 모드는 [메뉴 > 설정]에서\n언제든지 변경하실 수 있습니다.", attributes: [NSAttributedString.Key.kern: 0.08, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}
