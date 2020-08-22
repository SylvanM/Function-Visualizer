//
//  CGPoint+Math.swift
//  Function Visualizer
//
//  Created by Sylvan Martin on 7/28/20.
//  Copyright © 2020 Sylvan Martin. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGPoint {

    /**
     * Subtracts a `CGPoint` from this another
     */
    static func -= (lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x -= rhs.x
        lhs.y -= rhs.y
    }
    
    /**
     * Returns the angle this point makes on the unit circle in degrees
     *
     * I'd usually use radians, but this use requires degrees.
     */
    var angle: Double {
        
        /*
         * Return values:
         *  - 0: negative infinity
         *  - 1: finite
         *  - 2: positive infinity
         */
        func compareToInfinity(_ a: CGFloat) -> Int {
            
            if a.isFinite { return 1 }
            
            return a < 0 ? 0 : 2
            
        }
        
        // If any of the coordinates are infinite, we have to do some checking ourselves
        if !(self.x.isFinite && self.y.isFinite) {
            let angles: [[Double]] = [
                [225,   180,    135],
                [270,    -1,     90],
                [315,     0,      5]
            ]
            
            return angles[compareToInfinity(self.x)][compareToInfinity(self.y)]
        }
        
        var radians = Double(atan2(self.y, self.x))
    
        while radians < 0 {
            radians += Double(2 * Double.pi)
        }
        
        return radians * 180 / Double.pi
    }
    
    /**
     * The distance of a point from the origin
     */
    var magnitude: Double {
        sqrt((pow(Double(self.x), 2)) + pow(Double(self.y), 2))
    }
    
}
