//
//  Mode.swift
//  DarkModeLightMode
//
//  Created by 박형환 on 2022/09/21.
//

import Foundation

//ModeView의 상태 열거형
enum Mode: String{
    case dark = "다크 모드"
    case light = "라이트 모드"
    case none = "none"
}

// 앱에서 설정할 mode의 값
// viewModel에서 관리
enum ModeValue {
    case darkValue
    case lightValue
}
