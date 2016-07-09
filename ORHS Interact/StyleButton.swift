//
//  StyleButton.swift
//  
//
//  Created by Bernard Zhao on 7/7/16.
//
//

import Foundation
import UIKit
@IBDesignable class StyleButton: UIButton {
    var myValue: Int
    
    required init?(coder aDecoder: NSCoder) {
        // set myValue before super.init is called
        self.myValue = 0
        
        super.init(coder: aDecoder)
        layer.borderWidth = 1
        layer.borderColor = tintColor.CGColor
        layer.cornerRadius = 5.0
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        setTitleColor(tintColor, forState: .Normal)
        setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        setBackgroundImage(UIImage(color: tintColor), forState: .Highlighted)
        // set other operations after super.init, if required
        
    }
    
}