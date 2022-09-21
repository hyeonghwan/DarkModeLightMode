//
//  ViewModel.swift
//  DarkModeLightMode
//
//  Created by 박형환 on 2022/09/21.
//

import Foundation
import UIKit


final class ViewModel {
    
    var lightMode: Mode = Mode.light
    var darkMode: Mode = Mode.dark
    
    var darkImage = UIImage(named: "image_dark_mode")!
    var lightImage = UIImage(named: "image_light_mode")!
    
    
    // 데이터를 받아오면 뷰에게 이벤트 전달 -> 뷰 업데이트
    var modeValue: ModeValue = .lightValue {
        didSet{
            
            switch self.modeValue {
                
            case .lightValue:

                lightModeReloadView?(true)
                darkModeReloadView?(false)
                
            case .darkValue:
                
                darkModeReloadView?(true)
                lightModeReloadView?(false)
            }
        }
    }
    
    var darkModeReloadView: ((Bool) -> Void)? {
        didSet{
            print("darkModeReloadView didset")
        }
    }
    var lightModeReloadView: ((Bool) -> Void)? {
        didSet{
            print("lightModeReloadView didset")
        }
    }
}
