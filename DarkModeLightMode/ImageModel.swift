//
//  ImageModel.swift
//  DarkModeLightMode
//
//  Created by 박형환 on 2022/09/22.
//

import Foundation
import UIKit

struct ImageModel {
    var darkImage = UIImage(named: "image_dark_mode")!
    var lightImage = UIImage(named: "image_light_mode")!
    let imageSize = CGSize(width: 124, height: 153)
}
