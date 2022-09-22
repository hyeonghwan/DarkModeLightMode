//
//  API.swift
//  DarkModeLightMode
//
//  Created by 박형환 on 2022/09/22.
//

import Foundation


class API {
    static let appearance = Bundle.main.object(forInfoDictionaryKey: "UIUserInterfaceStyle") as? String
}
