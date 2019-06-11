//
//  UILabel+Extension.swift
//  Trend2201
//
//  Created by Mira on 2019/6/11.
//  Copyright © 2019 AppWork. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setYLabelStlye(item: Float, bgColor: UIColor, textColor: UIColor) {
        
        self.text = String(format: "%.2f", Float(item))
        
        self.backgroundColor = bgColor
        
        self.textColor = textColor
        
    }
    
}
