//
//  ViewModel.swift
//  DarkModeLightMode
//
//  Created by 박형환 on 2022/09/21.
//

import Foundation
import UIKit


protocol DarkModeLightModeProtocol {
    
    /// 데이터를 받아오면 뷰에게 이벤트 전달 -> ModeView뷰 업데이트
    var modeValue: ModeValue { get set }
    
    ///  vc에서 호출 되는 함수 - 이미지를 변경
    var updateImageForCurrentTraitCollection: (() -> Void)? { get set }
    
    
    /// ModeView의 버튼 이미지 변경 함수
    var darkModeReloadView: ((Bool) -> Void)? { get set }
    
    
    /// ModeView의 버튼 이미지 변경 함수
    var lightModeReloadView: ((Bool) -> Void)? { get set}
    
    
    /// vc의 setDisplayMode 함수 를 가져옴  ->  뷰 모드 변경 애니메이션 발동
    var updateUserInterfaceStyle: (() -> Void)? {get set}
    
    
    /// window.first 객체를 가져와 overrideUserInterfaceStyle Update
    func updateViewMode()
}

final class ViewModel: DarkModeLightModeProtocol {
    
    
    
    // viewModel init -> info.plist에서 UIUserInterfaceStyle value 가져와 초기세
    init() {
        updateViewMode()
    }
    
    func updateViewMode() {
        // window 객체
        let scenes = UIApplication.shared.connectedScenes
        let apperanceDic: [String : ModeValue]? = API.load()
    
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        if let apperanceDic = apperanceDic {
            
            guard let style = apperanceDic[API.appearance] else {return}
            
            switch style {
            case .lightValue:
                window?.overrideUserInterfaceStyle = .light
            case .darkValue:
                window?.overrideUserInterfaceStyle = .dark
            case .unspecified:
                break
            }
        }else {
            window?.overrideUserInterfaceStyle = .unspecified
        }
        self.modeValue = apperanceDic?[API.appearance] ?? .unspecified
    }
    
    ///view model 이 가지고 있는 모드 상태값, 데이터를 받아오면 뷰에게 이벤트 전달 -> 뷰 업데이트
    var modeValue: ModeValue = .unspecified {
        didSet{
         
            switch self.modeValue {
                
            case .lightValue:
                
                lightModeReloadView?(true)
                darkModeReloadView?(false)
                updateUserInterfaceStyle?()
                
            case .darkValue:
              
                darkModeReloadView?(true)
                lightModeReloadView?(false)
                updateUserInterfaceStyle?()
            case .unspecified:
                break
            }
        }
    }
    
    var updateImageForCurrentTraitCollection: (() -> ())?
    
    var updateUserInterfaceStyle: (()->())? 
    
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
