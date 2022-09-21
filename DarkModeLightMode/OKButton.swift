//
//  OKButton.swift
//  DarkModeLightMode
//
//  Created by 박형환 on 2022/09/21.
//

import Foundation
import UIKit


class OKButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.textAlignment = .center
        self.backgroundColor = UIColor(red: 0.263, green: 0.61, blue: 0.988, alpha: 1)
        self.setTitleColor(UIColor.white, for: .normal)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.62
        let att = NSAttributedString(string: "확인", attributes: [NSAttributedString.Key.kern: 0.35, NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font : UIFont(name: "NanumGothicBold", size: 15)!])
        self.setAttributedTitle(att, for: .normal)
    }
    required init?(coder: NSCoder) {
        fatalError("required init fatalError okbutton")
    }
}
