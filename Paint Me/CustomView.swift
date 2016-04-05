//
//  CustomView.swift
//  Paint Me
//
//  Created by Adis Mulabdic on 4/1/16.
//  Copyright © 2016 Adis Mulabdic. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    override func awakeFromNib() {
        
        layer.cornerRadius = 3.0
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 1.0).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 2.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
    }
    
}
