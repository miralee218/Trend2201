//
//  ShapeLayerManager.swift
//  Trend2201
//
//  Created by Mira on 2019/6/11.
//  Copyright © 2019 AppWork. All rights reserved.
//

import UIKit

class ShapeLayerManager {
    static func setShapeLayer(strokeColor: CGColor, layerFrame: CGRect) -> CAShapeLayer {
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = layerFrame
        shapeLayer.lineWidth = 1
        shapeLayer.strokeColor = strokeColor
        
        return shapeLayer
    }
    
    static func setShapeLayer(strokeColor: CGColor, fillColor: CGColor?, layerFrame: CGRect) -> CAShapeLayer {
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = layerFrame
        shapeLayer.fillColor = fillColor
        shapeLayer.lineWidth = 0.5
        shapeLayer.strokeColor = strokeColor
        
        return shapeLayer
    }
    
    static func addShapeLayer(shapeLayer: CAShapeLayer, bezierPath: UIBezierPath, view: UIView) {
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.position = view.center
        view.layer.addSublayer(shapeLayer)
    }
    
}
