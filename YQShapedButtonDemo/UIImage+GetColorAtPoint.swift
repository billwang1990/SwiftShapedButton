//
//  UIImage+GetColorAtPoint.swift
//  YQShapedButtonDemo
//
//  Created by Yaqing Wang on 10/13/15.
//  Copyright © 2015 thoughtworks.com. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    
    //Get more detail http://stackoverflow.com/questions/25146557/how-do-i-get-the-color-of-a-pixel-in-a-uiimage-with-swift
    func getPixelColor(pos: CGPoint) -> UIColor {
        
        let pixelData = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage))
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    func colorAtPixel(point:CGPoint) -> UIColor{
        
        let pointX = trunc(point.x)
        let pointY = trunc(point.y)
        let cgImage = self.CGImage
        let width = self.size.width
        let height = self.size.height
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var pixelData: [CUnsignedChar]  = [0, 0, 0, 0]
        let bytesPerPixel: Int = 4
        let bytesPerRow: Int = bytesPerPixel * 1
        let bitsPerComponent: Int = 8

        let context = CGBitmapContextCreate(&pixelData, 1, 1, bitsPerComponent, bytesPerRow, colorSpace, CGImageAlphaInfo.PremultipliedLast.rawValue)
        
        CGContextSetBlendMode(context, CGBlendMode.Copy)
        CGContextTranslateCTM(context, -pointX, pointY - CGFloat(height));
        CGContextDrawImage(context, CGRectMake(0.0, 0.0, CGFloat(width), CGFloat(height)), cgImage);
        
        let red   = CGFloat(pixelData[0]) / 255.0;
        let green = CGFloat(pixelData[1]) / 255.0;
        let blue  = CGFloat(pixelData[2]) / 255.0;
        let alpha = CGFloat(pixelData[3]) / 255.0;
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}