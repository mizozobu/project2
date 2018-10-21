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
    // Mark - Properties
    var temple = Temple(filename: "adsf", name: "adsf")
    @IBInspectable var isStudyMode = false
    var borderStrokeWidth : CGFloat { return 10 }
    var borderColor = UIColor.blue
    
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
        UIColor.blue.setFill()
        UIRectFill(bounds)
        
        guard let templeImage = UIImage(named: temple.filename) else {
            return
        }
        
        let width = bounds.width
        let height = bounds.height
        let templeImageRect = CGRect(
            x: 0,
            y: 0,
            width: width,
            height: height
        )
        templeImage.draw(in: templeImageRect)
        
        let square = UIBezierPath()
        borderColor.setStroke()
        square.lineWidth = borderStrokeWidth
        square.move(to: CGPoint(x: 0, y: 0)) // top left
        square.addLine(to: CGPoint(x: width, y: 0)) // top right
        square.addLine(to: CGPoint(x: width, y: height)) // bottom right
        square.addLine(to: CGPoint(x: 0, y: height)) // bottom left
        square.close()
        square.stroke()
        
        if self.isStudyMode {
            let templeNameLabel = NSAttributedString(string: temple.name, attributes: [.foregroundColor: UIColor.white])
            var textBounds = CGRect.zero
            textBounds.size = templeNameLabel.size()
            textBounds.origin = CGPoint(x: (bounds.width - textBounds.width) / 2, y: (bounds.height - textBounds.height) / 2)
            templeNameLabel.draw(in: textBounds)
        }
    }
}
