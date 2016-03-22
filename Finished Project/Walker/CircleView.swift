//
//  CircleView.swift
//  CAENCheck
//
//  Created by Russell Ladd on 3/17/15.
//  Copyright (c) 2015 The Regents of the University of Michigan. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable class CircleView: UIView {
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    func commonInit() {
        
        updatePath()
        updateFillColor()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        updatePath()
        updateFillColor()
    }
    
    // MARK: Properties
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        
        updateFillColor()
    }
    
    override var bounds: CGRect {
        didSet {
            updatePath()
        }
    }
    
    // MARK: Shape layer
    
    override class func layerClass() -> AnyClass {
        return CAShapeLayer.self
    }
    
    private var shapeLayer: CAShapeLayer {
        return layer as! CAShapeLayer
    }
    
    private func updatePath() {
        shapeLayer.path = UIBezierPath(ovalInRect: bounds).CGPath
    }
    
    private func updateFillColor() {
        shapeLayer.fillColor = tintColor.CGColor
    }
}
