//
//  SelectButton.swift
//  DarkModeLightMode
//
//  Created by 박형환 on 2022/09/21.
//

import Foundation
import UIKit
import SnapKit


class SelectButton: UIButton {
    private let selectedColor = UIColor(red: 0.263, green: 0.61, blue: 0.988, alpha: 1).cgColor
    private let normalColor = UIColor(red: 0.855, green: 0.859, blue: 0.871, alpha: 1).cgColor
    
    override var isSelected: Bool {
        didSet {
            self.layer.borderColor =
            self.isSelected ? selectedColor : normalColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    private func configure() {
        self.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.backgroundColor = .white
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = normalColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
}
