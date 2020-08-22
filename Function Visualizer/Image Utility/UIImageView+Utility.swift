//
//  UIImageView+Utility.swift
//  Function Visualizer
//
//  Created by Sylvan Martin on 7/28/20.
//  Copyright © 2020 Sylvan Martin. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

extension UIImageView {
    
    // MARK: Pixel Utility
    
    /**
     * Sets the pixels of this image to those that will display a given point array represented by color
     */
    func setPixels(_ pixels: [UInt32]) {
        
        let bitsPerComponent = 8
        let bitsPerPixel = 32
        
        var data = pixels // Copy to mutable array
        
        let providerRef = CGDataProvider(
            data: NSData(bytes: &data, length: data.count * 4)
        )
        
        let cgim = CGImage(
            width: Int(self.bounds.width),
            height: Int(self.bounds.height),
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bitsPerPixel,
            bytesPerRow: Int(self.bounds.width) * 4,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue),
            provider: providerRef!,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
        )
        
        self.image = UIImage(cgImage: cgim!)
        
    }
    
    // MARK: Color
    
    /**
     * Converts a vector field to a 2D array of pixels to be displayed
     */
    static func convertToPixels(for field: Math.VectorField) -> [UInt32] {
        field.points.flatMap {
            $0.map { point -> UInt32 in
                let hue = point.angle
                
                // TODO: Actually calculate the saturation
                var saturation = compress(point.magnitude, max: field.max)
                
                var mid: Double {
                    let inner = (hue / 60).truncatingRemainder(dividingBy: 2)
                    return saturation * (1 - abs(inner - 1))
                }
                
                let m = 1 - saturation
                
                let rgbPrimes: [Double] =
                     hue < 60  ? [saturation, mid, 0] :
                    (hue < 120 ? [mid, saturation, 0] :
                    (hue < 180 ? [0, saturation, mid] :
                    (hue < 240 ? [0, mid, saturation] :
                    (hue < 300 ? [mid, 0, saturation] :
                                 [saturation, 0, mid]))))
                
                var rgba: [UInt8] = [0, 0, 0, 1]
                
                for i in 0...2 { rgba[i] = UInt8((rgbPrimes[i] + m) * 255) }
                
                return mask(rgba)
            }
        }
    }
    
    private static func compress(_ x: Double, max: Double) -> Double {
        
        return x / max
        
    }
    
    // MARK: Convenience
    
    private static func mask(_ rgba: [UInt8]) -> UInt32 {
        return rgba.withUnsafeBytes {
            $0.bindMemory(to: UInt32.self)
        }.map {
            $0.bigEndian
        }.first!
    }
    
}
