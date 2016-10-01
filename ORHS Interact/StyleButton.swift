//
//  StyleButton.swift
//  
//
//  Created by Bernard Zhao on 7/7/16.
//
//

import UIKit
class StyleButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
        
    }
    
    init(){
        super.init(frame: CGRect.zero)
        setUp()
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    func setUp(){
        layer.borderWidth = 1
        layer.borderColor = tintColor.cgColor
        layer.cornerRadius = 5.0
        clipsToBounds = true
        setTitleColor(tintColor, for: UIControlState())
        setTitleColor(UIColor.white, for: .highlighted)
        setBackgroundImage(UIImage(color: tintColor), for: .highlighted)
        setTitleColor(UIColor(red:1.00, green:1.00, blue:0.60, alpha:1.0), for: .highlighted)
        // set other operations after super.init, if required
    }
}
