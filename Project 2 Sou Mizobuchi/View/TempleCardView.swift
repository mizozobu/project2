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
    @IBInspectable var isMatched = false
    
    // Mark - Computed Properties
    var borderWidth : CGFloat { return 1 }
    var cornerRadious : CGFloat { return bounds.width * 0.05  }
    var centerImageMargin    : CGFloat { return 0 }
//    var cornerImageWidth     : CGFloat { return bounds.width * 0.18 }
    
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
        let roundRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadious)
        
        roundRect.addClip()
        UIColor.red.setFill()
        UIRectFill(bounds)
        
        guard let templeImage = UIImage(named: "bismarck-temple-lds-408056-mobile.jpg") else {
            return
        }
        
        let width = bounds.width - 2 * centerImageMargin
        let templeImageRect = CGRect(
            x: centerImageMargin,
            y: (bounds.height - width) / 2,
            width: width,
            height: width
        )
        
        templeImage.draw(in: templeImageRect)
    }

}
