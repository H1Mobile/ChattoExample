//
//  UIColor+HexColor.swift
//  venus
//
//  Created by Diego de Paz Sierra on 4/15/16.
//  Copyright © 2016 Sirena. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(red: Int, green: Int, blue: Int, alphaHex: Float) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        assert(alphaHex >= 0 && alphaHex <= 255, "Invalid alpha component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alphaHex))
    }
    
    convenience init(hexString: String) {
        var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) { cString.removeFirst() }
        
        if ((cString.count) != 6) {
            self.init(hexString: "90a4ae") // return gray color for wrong hex input
            return
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        let redColor: CGFloat = CGFloat(CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0)
        let greenColor: CGFloat = CGFloat(CGFloat((rgbValue & 0xFF00) >> 8) / 255.0)
        let blueColor: CGFloat = CGFloat(CGFloat(rgbValue & 0xFF) / 255.0)
        
        self.init(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0)
    }
    
}

