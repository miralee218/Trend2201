//
//  StockChartViewController.swift
//  Trend2201
//
//  Created by Mira on 2019/6/10.
//  Copyright © 2019 AppWork. All rights reserved.
//

import UIKit

class StockChartViewController: ViewController {
    
    var chartBackgroundView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        let label = UILabel(frame: CGRect(x: 50, y: 70, width: 150, height: 22))
        label.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        label.text = "商品代碼：" + String(stk)
        view.addSubview(label)
        
        chartBackgroundView = UIView(frame: CGRect(x: 50, y: 100, width: UIScreen.chartWidth, height: UIScreen.chartWidth))
        chartBackgroundView.backgroundColor = .black
        view.addSubview(chartBackgroundView)
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        drawGrid()
        addYLabel()
        addXLabel()
        getAllPoint(root)
    }
    


    func addYLabel() {

        for index in 0...4{
            let label = UILabel(frame: CGRect(x: -45, y: UIScreen.chartWidth * Double(index) / 4 - Double(index) * 6, width: 45, height: 24))
            
            switch index {
            case 0:
                label.text = String(tp)
                label.backgroundColor = UIColor.red
                label.textColor = UIColor.white
            case 1:
                label.text = String(format: "%.2f", Float(c)*1.05)
                label.textColor = UIColor.red
            case 2:
                label.text = String(format: "%.2f", Float(c))
                label.textColor = UIColor.white
            case 3:
                label.text = String(format: "%.2f", Float(c)*0.95)
                label.textColor = UIColor.green
            case 4:
                label.text = String(format: "%.2f", Float(bp))
                label.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)
                label.textColor = UIColor.white
            default:
                label.text = "N/A"
            }

            label.textAlignment = .right

            chartBackgroundView.addSubview(label)
        }

    }
    
    func addXLabel() {

        for index in 0...4 {
            let label = UILabel(frame: CGRect(x: Double(index) * UIScreen.chartWidth * 2 / 9 - 20, y: UIScreen.chartWidth, width: 40, height: 22))

            if index == 0 {
                label.text = "09"
            } else {
                label.text = "\(index + 9)"
            }
            label.textAlignment = .right
            label.textColor = UIColor.white

            chartBackgroundView.addSubview(label)
        }

    }
    
    
    func addShapeLayer(_ shapeLayer: CAShapeLayer, path: UIBezierPath, view: UIView) {
        shapeLayer.path = path.cgPath
        shapeLayer.position = view.center
        view.layer.addSublayer(shapeLayer)
    }
    
    
    func drawGrid() {
        
        let totalTime = tickT.count.quotientAndRemainder(dividingBy: 60)
        var totalHours = Int()
        if totalTime.remainder > 0 {
            totalHours = totalTime.quotient + 1
        } else {
            totalHours = totalTime.quotient
        }
        // add Y Grid
        for index in 0...4 {
            let shapeLayer = ShapeLayerManager.setShapeLayer(strokeColor: CGColor.gray, layerFrame: chartBackgroundView.frame)
            let path = UIBezierPath()
            
            path.transCoMove(to: CGPoint(x: 0, y: UIScreen.chartWidth * Double(index) / 4))
            path.transCoAddLine(to: CGPoint(x: UIScreen.chartWidth, y: UIScreen.chartWidth * Double(index) / 4))
            
            addShapeLayer(shapeLayer, path: path, view: chartBackgroundView)
        }
        
        // add X Grid
        for index in stride(from: 0, to: 9, by: 2) {
            let shapeLayer = ShapeLayerManager.setShapeLayer(strokeColor: CGColor.gray, layerFrame: chartBackgroundView.frame)
            let path = UIBezierPath()
            
            path.transCoMove(to: CGPoint(x: UIScreen.chartWidth * Double(index) / 9, y: 0))
            path.transCoAddLine(to: CGPoint(x: UIScreen.chartWidth * Double(index) / 9, y: UIScreen.chartWidth))
            
            addShapeLayer(shapeLayer, path: path, view: chartBackgroundView)
        }
        
        addLastXGrid()
    }
    
    func getAllPoint(_ content: Trend?) {
        let shapeLayer = ShapeLayerManager.setShapeLayer(strokeColor: CGColor.red, fillColor: CGColor.redAlpha, layerFrame: chartBackgroundView.frame)
        let path = UIBezierPath()
        
      
            path.transCoMove(to: CGPoint(x: 0, y: UIScreen.chartWidth / 2))
            path.transCoAddLine(to: CGPoint(x: 0, y: UIScreen.chartWidth / 2))
            for index in tickC.indices {
                
                let tempX = Double(tickT[index]) *  UIScreen.chartWidth / Double(tickT.last!)
                let tempY = (Double(tickC[index] - c)) * UIScreen.chartWidth / (c * 0.1 * 2) + UIScreen.chartWidth / 2
                path.transCoAddLine(to: CGPoint(x: tempX, y: tempY))
            }
            path.transCoAddLine(to: CGPoint(x:  UIScreen.chartWidth, y: UIScreen.chartWidth / 2))
        
        
        addShapeLayer(shapeLayer, path: path, view: chartBackgroundView)
        
    }
    
    private func addLastXGrid() {
        let shapeLayer = ShapeLayerManager.setShapeLayer(strokeColor: CGColor.red, fillColor: CGColor.redAlpha, layerFrame: chartBackgroundView.frame)
        let path = UIBezierPath()

        path.transCoMove(to: CGPoint(x: UIScreen.main.bounds.width - 70, y: 0))
        path.transCoAddLine(to: CGPoint(x: UIScreen.main.bounds.width - 70, y:  UIScreen.main.bounds.width))

        addShapeLayer(shapeLayer, path: path, view: chartBackgroundView)
    }


}

extension UIBezierPath {
    
    func transCoMove(to: CGPoint, y: CGFloat = CGFloat(UIScreen.chartWidth)) {
        
        self.move(to: CGPoint(x: to.x, y: y - to.y))
    }
    
    func transCoAddLine(to: CGPoint, y: CGFloat = CGFloat(UIScreen.chartWidth)) {
        
        self.addLine(to: CGPoint(x: to.x, y: y - to.y))
        
    }
}
