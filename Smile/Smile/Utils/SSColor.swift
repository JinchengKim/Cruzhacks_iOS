//
//  SSColor.swift
//  Smile
//
//  Created by 李金 on 1/18/19.
//  Copyright © 2019 Kingandyoga. All rights reserved.
//

import UIKit

import Foundation
import UIKit

// Get Color
func RGBA(_ R:CGFloat,_ G:CGFloat,_ B:CGFloat,_ A:CGFloat) -> UIColor {
    return UIColor.init(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: A/255.0)
}

func RGB(_ R:CGFloat,_ G:CGFloat,_ B:CGFloat) -> UIColor {
    
    return UIColor.init(red: R/255.0, green: G/255.0, blue: B/255.0, alpha:1)
}

func createImageWithColor(_ color: UIColor) -> UIImage{
    return createImageWithColor(color, size: CGSize(width: 1, height: 1))
}

func createImageWithColor(_ color:UIColor, size:CGSize) -> UIImage{
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(color.cgColor)
    context?.fill(rect)
    
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img!
}

protocol JCColorProtocol {
    var jc_backgroundColor:UIColor {get}
    //    var jc_titleColor:UIColor {get}
    
    
}

class JCDefaultColor: NSObject, JCColorProtocol {
    static let sharedInstance = JCDefaultColor()
    var jc_backgroundColor: UIColor = RGB(62, 63, 93)
}


@objc extension UIColor {
    /**
     The shorthand three-digit hexadecimal representation of color.
     #RGB defines to the color #RRGGBB.
     
     - parameter hex3: Three-digit hexadecimal value.
     - parameter alpha: 0.0 - 1.0. The default is 1.0.
     */
    public convenience init(hex3: UInt16, alpha: CGFloat = 1) {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex3 & 0xF00) >> 8) / divisor
        let green   = CGFloat((hex3 & 0x0F0) >> 4) / divisor
        let blue    = CGFloat( hex3 & 0x00F      ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The shorthand four-digit hexadecimal representation of color with alpha.
     #RGBA defines to the color #RRGGBBAA.
     
     - parameter hex4: Four-digit hexadecimal value.
     */
    public convenience init(hex4: UInt16) {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex4 & 0xF000) >> 12) / divisor
        let green   = CGFloat((hex4 & 0x0F00) >>  8) / divisor
        let blue    = CGFloat((hex4 & 0x00F0) >>  4) / divisor
        let alpha   = CGFloat( hex4 & 0x000F       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The six-digit hexadecimal representation of color of the form #RRGGBB.
     
     - parameter hex6: Six-digit hexadecimal value.
     */
    public convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The six-digit hexadecimal representation of color with alpha of the form #RRGGBBAA.
     
     - parameter hex8: Eight-digit hexadecimal value.
     */
    public convenience init(hex8: UInt32) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
        let green   = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
        let blue    = CGFloat((hex8 & 0x0000FF00) >>  8) / divisor
        let alpha   = CGFloat( hex8 & 0x000000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    //
    //    /**
    //     The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, throws error.
    //
    //     - parameter rgba: String value.
    //     */
    //    public convenience init(rgba_throws rgba: String) throws {
    //        guard rgba.hasPrefix("#") else {
    //            let error = UIColorInputError.missingHashMarkAsPrefix(rgba)
    //            print(error.localizedDescription)
    //            throw error
    //        }
    //
    //        let hexString: String = String(rgba[String.Index.init(encodedOffset: 1)...])
    //        var hexValue:  UInt32 = 0
    //
    //        guard Scanner(string: hexString).scanHexInt32(&hexValue) else {
    //            let error = UIColorInputError.unableToScanHexValue(rgba)
    //            print(error.localizedDescription)
    //            throw error
    //        }
    //
    //        switch (hexString.count) {
    //        case 3:
    //            self.init(hex3: UInt16(hexValue))
    //        case 4:
    //            self.init(hex4: UInt16(hexValue))
    //        case 6:
    //            self.init(hex6: hexValue)
    //        case 8:
    //            self.init(hex8: hexValue)
    //        default:
    //            let error = UIColorInputError.mismatchedHexStringLength(rgba)
    //            print(error.localizedDescription)
    //            throw error
    //        }
    //    }
    //
    //    /**
    //     The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, fails to default color.
    //
    //     - parameter rgba: String value.
    //     */
    //    public convenience init(_ rgba: String, defaultColor: UIColor = UIColor.clear) {
    //        guard let color = try? UIColor(rgba_throws: rgba) else {
    //            self.init(cgColor: defaultColor.cgColor)
    //            return
    //        }
    //        self.init(cgColor: color.cgColor)
    //    }
    //
    //    /**
    //     Hex string of a UIColor instance, throws error.
    //
    //     - parameter includeAlpha: Whether the alpha should be included.
    //     */
    //    public func hexStringThrows(_ includeAlpha: Bool = true) throws -> String  {
    //        var r: CGFloat = 0
    //        var g: CGFloat = 0
    //        var b: CGFloat = 0
    //        var a: CGFloat = 0
    //        self.getRed(&r, green: &g, blue: &b, alpha: &a)
    //
    //        guard r >= 0 && r <= 1 && g >= 0 && g <= 1 && b >= 0 && b <= 1 else {
    //            let error = UIColorInputError.unableToOutputHexStringForWideDisplayColor
    //            print(error.localizedDescription)
    //            throw error
    //        }
    //
    //        if (includeAlpha) {
    //            return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
    //        } else {
    //            return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    //        }
    //    }
    
    /**
     Hex string of a UIColor instance, fails to empty string.
     
     - parameter includeAlpha: Whether the alpha should be included.
     */
    //    public func hexString(_ includeAlpha: Bool = true) -> String  {
    //        guard let hexString = try? hexStringThrows(includeAlpha) else {
    //            return ""
    //        }
    //        return hexString
    //    }
}