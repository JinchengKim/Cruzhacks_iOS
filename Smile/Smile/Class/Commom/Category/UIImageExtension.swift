//
//  UIImageExtension.swift
//  Smile
//
//  Created by 李金 on 1/18/19.
//  Copyright © 2019 Kingandyoga. All rights reserved.
//

import UIKit

extension UIImage {
    
    func cropImage( toRect cropRect: CGRect, viewWidth: CGFloat, viewHeight: CGFloat) -> UIImage?
    {
        let imageViewScale = max(self.size.width / viewWidth,
                                 self.size.height / viewHeight)
        
        // Scale cropRect to handle images larger than shown-on-screen size
        let cropZone = CGRect(x:cropRect.origin.x * imageViewScale,
                              y:cropRect.origin.y * imageViewScale,
                              width:cropRect.size.width * imageViewScale,
                              height:cropRect.size.height * imageViewScale)
        
        // Perform cropping in Core Graphics
        guard let cutImageRef: CGImage = self.cgImage?.cropping(to:cropZone)
            else {
                return nil
        }
        
        // Return image to UIImage
        let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
        return croppedImage
    }
    
    func rotate(withangle angle: CGFloat) -> UIImage {
        let radians = CGFloat(angle * .pi) / 180.0 as CGFloat
        let rotatedSize = self.size
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(rotatedSize, false, scale)
        let bitmap = UIGraphicsGetCurrentContext()
        bitmap?.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        bitmap?.rotate(by: radians)
        bitmap?.scaleBy(x: 1.0, y: -1.0)
        bitmap?.draw(
            self.cgImage!,
            in: CGRect.init(x: -self.size.width / 2, y: -self.size.height / 2 , width: self.size.width, height: self.size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext() // this is needed
        return newImage!
    }
    
    func image(withBrightness b:CGFloat, withContrast c:CGFloat, withSaturation s:CGFloat) -> UIImage? {
        guard let beginImage = CIImage(image: self) else {
            return nil
        }
        let parameters = [kCIInputImageKey      : beginImage,
                          kCIInputBrightnessKey : b,
                          kCIInputContrastKey   : c,
                          kCIInputSaturationKey : s] as [String : Any]
        
        let blackAndWhite = CIFilter(name: "CIColorControls",
                                     parameters: parameters)?.outputImage
        let outputParam = [kCIInputImageKey : blackAndWhite as Any,
                           kCIInputEVKey: 0.7] as [String : Any]
        let output = CIFilter(name: "CIExposureAdjust", parameters: outputParam)?.outputImage
        guard let outputCI = output else {
            return nil
        }
        let context = CIContext(options: nil)
        guard let cgimage = context.createCGImage(outputCI, from: outputCI.extent) else {
            return nil
        }
        return UIImage(cgImage: cgimage, scale: 0, orientation: self.imageOrientation)
    }
}


extension UIImageView{
    
}
