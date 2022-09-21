//
//  Extension.swift
//  DarkModeLightMode
//
//  Created by 박형환 on 2022/09/21.
//

import Foundation
import UIKit


//라벨 환경설정
extension UILabel {
    func settingTitleLabel() {
         self.backgroundColor = .systemBackground
         self.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
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
    
    func settingRedLabel() {
        self.frame = CGRect(x: 0, y: 0, width: 216, height: 41)
        self.backgroundColor = .white
        self.textColor = UIColor(red: 0.892, green: 0.368, blue: 0.368, alpha: 1)
        self.font = UIFont(name: "NanumGothicBold", size: 16)
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.13
        self.textAlignment = .center
        self.attributedText = NSMutableAttributedString(string: "화면 모드는 [메뉴 > 설정]에서\n언제든지 변경하실 수 있습니다.", attributes: [NSAttributedString.Key.kern: 0.08, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    
    
}
