//
//  Math.swift
//  Function Visualizer
//
//  Created by Sylvan Martin on 7/28/20.
//  Copyright © 2020 Sylvan Martin. All rights reserved.
//

import Foundation
import CoreGraphics

/**
 * Class for all math that needs to be done
 */
class Math {
    
    // MARK: Typealiases
    
    typealias Function = (CGPoint) -> CGPoint
    
    typealias FunctionWindow = (domain: ClosedRange<Double>, range: ClosedRange<Double>)
    typealias VectorField    = (points: [[CGPoint]], max: Double)
    
    // MARK: Properties
    
    var function: Function = { $0 } //{ CGPoint(x: atan2($0.y, $0.x), y: $0.y * $0.x) }
    
    // MARK: Methods
    
    /**
     * Calculates all new vectors for the function over a certain window
     *
     * - Parameters:
     *      - window: The domain and range over which to calculate function values
     *      - rect: The pixel dimensions of the vector field
     *      - shouldCalculateDifferences: A `Bool` value indicating whether or not the function should only calculate the change made to its inputs
     *
     * - Returns: A two dimensional array of all the resulting points to display
     */
    func calculateVectorField(over window: FunctionWindow, for rect: CGRect, shouldCalculateDifferences: Bool = false) -> VectorField {
        
        // the vector field to return, as well as the maximum magnitude found
        var points = [[CGPoint]](repeating: [CGPoint](repeating: CGPoint.zero, count: Int(rect.width)), count: Int(rect.height))
        var max: Double = 0
        
        // iterate through the pixels in the rect and calculate a CGPoint for each one
        
        let windowWidth  = window.domain.upperBound - window.domain.lowerBound
        let windowHeight = window.range.upperBound - window.range.lowerBound
        
        for y in 0..<Int(rect.height) {
            
            for x in 0..<Int(rect.width) {
                
                let input = CGPoint(x: ((Double(x) / Double(rect.width))  * windowWidth)  + window.domain.lowerBound,
                                    y: ((Double(y) / Double(rect.height)) * windowHeight) + window.range.lowerBound)
                
                var output = function(input)
                
                if shouldCalculateDifferences {
                    output -= input
                }
                
                // I know this isn't the ACTUAL magnitude of the point, but it's all we need to calculate, and I couldn't think of a better variable name
                let magnitude = Double(pow(output.x, 2) + pow(output.y, 2))
                
                if magnitude > max {
                    // this way, we only calculate the square root if we need to, which will save time
                    max = magnitude
                }
                
                points[y][x] = output
                
            }
        }
        
        return (points: points, max: sqrt(max))
        
    }
    
}
