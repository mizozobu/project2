//
//  TempleCardView.swift
//  Project 2 Sou Mizobuchi
//
//  Created by user144546 on 10/12/18.
//  Copyright © 2018 IS543. All rights reserved.
//

import UIKit

@IBDesignable
class TempleCardView : UIView {
    // Mark - Constants
    private struct TempleCard {
        
    }
    
    // Mark - Properties
    var temple = Temple(filename: "adsf", name: "adsf")
    @IBInspectable var isMatched = false
    
    // Mark - Computed Properties
    var borderStrokeWidth : CGFloat { return 10 }
    
    // Mark - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.clear
        isOpaque = false
    }
    
    // Mark - Draw
    override func draw(_ rect: CGRect) {
        let rect = UIBezierPath(rect: bounds)

        rect.addClip()
        UIColor.red.setFill()
        UIRectFill(bounds)
        
        guard let templeImage = UIImage(named: temple.filename) else {
            return
        }
        
        let width = bounds.width
        let height = bounds.height
        let templeImageRect = CGRect(
            x: 0,
            y: (bounds.height - width) / 2,
            width: width,
            height: height
        )
        templeImage.draw(in: templeImageRect)
        
        let square = UIBezierPath()
        UIColor.blue.setStroke()
        square.lineWidth = borderStrokeWidth
        square.move(to: CGPoint(x: 0, y: 0)) // top left
        square.addLine(to: CGPoint(x: width, y: 0)) // top right
        square.addLine(to: CGPoint(x: width, y: height)) // bottom right
        square.addLine(to: CGPoint(x: 0, y: height)) // bottom left
        square.close()
        square.stroke()
    }

}
