//
//  UIImage+Utils.swift
//  ChattoApp
//
//  Created by Maca on 26/08/2018.
//  Copyright © 2018 Badoo. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func tinted(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        color.set()
        withRenderingMode(.alwaysTemplate)
            .draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
