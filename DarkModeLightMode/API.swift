//
//  API.swift
//  DarkModeLightMode
//
//  Created by 박형환 on 2022/09/22.
//

import Foundation
import UIKit


class API {
    
    ///  plist key value
    static let appearance = "Appearance"
    
    static private var fileURL: URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent("appearance.plist")
    }
    
    /// app 이 실행될때 ViewModel 에서 호출
    ///  app의 Appearance 값을 derectory에서 가져오는 함수
    /// - Returns: Appearance dictionary type
    static func load() -> [String : ModeValue]? {
        let decoder = PropertyListDecoder()
        guard let style = try? Data.init(contentsOf: fileURL),
              let styleInfo =
                try? decoder.decode([String : ModeValue].self, from: style)
        else {print("fileURL not exist"); return nil }
        return styleInfo
      }
    
    
    ///  plist에 값 을 write 하는 함수
    /// - Parameters:
    ///   - style: data
    ///   - completion:  데이터를 입력후 컴플리션 블록 실행
    static func write(style: [String : ModeValue],
                      _ completion :@escaping (() -> Void)) {
        let encoder = PropertyListEncoder()
        if let styleData = try? encoder.encode(style) {
            if FileManager.default.fileExists(atPath: fileURL.path) {
                try? styleData.write(to: fileURL)
            } else {
                FileManager.default.createFile(atPath: fileURL.path,
                                               contents : styleData,
                                               attributes: nil)
        }
      }
        completion()
    }
}

