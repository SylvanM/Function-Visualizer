//
//  ViewController.swift
//  Function Visualizer
//
//  Created by Sylvan Martin on 7/28/20.
//  Copyright © 2020 Sylvan Martin. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    
    // MARK: Properties
    
    var math = Math()
    
    var window: Math.FunctionWindow = (domain: -10...10, range: -10...10)
    
    /// The `UIImageView` that displays the graph
    @IBOutlet weak var graphImageView: UIImageView!
    
    /// The height, in pixels, of the graph image view
    var height: Int {
        Int(graphImageView.bounds.height)
    }
    
    /// The width, in pixels, of the graph image view
    var width: Int {
        Int(graphImageView.bounds.width)
    }
    
    // MARK: View Controller

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshGraphView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        refreshGraphView()
    }

    // MARK: Functions
    
    /**
     * Displays the graph of whatever function has been programmed
     */
    func refreshGraphView() {
        
        let alert = UIAlertController(title: "Graphing Function", message: "This may take a while", preferredStyle: .alert)
        self.present(alert, animated: true)
        
        let rect   = CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: height))
        let field  = math.calculateVectorField(over: window, for: rect)
        let pixels = UIImageView.convertToPixels(for: field)
        
        self.graphImageView.setPixels(pixels)
        
        self.dismiss(animated: true)
        
    }

}

