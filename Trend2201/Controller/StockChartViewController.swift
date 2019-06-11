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
    let xPoint = 50.0
    let yPoint = 100.0
    let chartWidth = UIScreen.chartWidth
    let chartHeight = UIScreen.chartWidth
    let labelHeight = 24.0
    let labelWidth = 50.0
    var indexCount = Int()
    let gridCount = 4.5
    
    var barChartBackgroundView = UIView()
    let barXPoint = 50.0
    let barYPoint = 100.0 + UIScreen.chartWidth + 50
    let barWidth = UIScreen.chartWidth
    let barHeight = UIScreen.chartWidth / 3

    override func viewDidLoad() {
        super.viewDidLoad()
        
        indexCount = GridManager.getYAxisCount(allTime: tickT) - 1
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setStokeName()
        setBackgrounds()
        drawGrid()
        setYLabel()
        setXLabel()
        setChartView()
        setMaxChartView()
        setMinChartView()
        
        drawBarGrid()
        setBarChartView()
        
    }
    
    func setStokeName() {
        
        let label = UILabel(frame: CGRect(x: 50, y: 70, width: 150, height: 22))
        label.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        label.text = "商品代碼：" + String(stk)
        view.addSubview(label)
        
    }
    
    func setBackgrounds() {
        
        chartBackgroundView = UIView(frame: CGRect(x: xPoint, y: yPoint, width: chartWidth, height: chartHeight))
        
        chartBackgroundView.backgroundColor = .black
        
        view.addSubview(chartBackgroundView)
        
        barChartBackgroundView = UIView(frame: CGRect(x: barXPoint, y: barYPoint, width: barWidth, height: barHeight))
        
        barChartBackgroundView.backgroundColor = .black
        
        view.addSubview(barChartBackgroundView)
        
    }
    
    func setYLabel() {

        for index in 0...indexCount {
            
            let former = chartWidth * Double(index) / Double(indexCount)
            
            let latter = Double(index) * labelHeight / Double(indexCount)
            
            let label = UILabel(frame: CGRect(x: -xPoint, y: former - latter, width: labelWidth, height: labelHeight))
            
            switch index {
                
            case 0:
                label.setYLabelStlye(item: Float(tp), bgColor: UIColor.red, textColor: UIColor.white)
            case 1:
                label.setYLabelStlye(item: Float(c) * 1.05, bgColor: UIColor.clear, textColor: UIColor.red)
            case 2:
                label.setYLabelStlye(item: Float(c), bgColor: UIColor.clear, textColor: UIColor.white)
            case 3:
                label.setYLabelStlye(item: Float(Float(c) * 0.95), bgColor: UIColor.clear, textColor: UIColor.green)
            case 4:
                label.setYLabelStlye(item: Float(bp), bgColor: UIColor(red: 0, green: 0.5, blue: 0, alpha: 1), textColor: UIColor.white)
            default:
                label.text = "N/A"
                
            }
            
            label.textAlignment = .right

            chartBackgroundView.addSubview(label)
        }

    }

    
    func setXLabel() {

        for index in 0...indexCount {
            let label = UILabel(frame:
                CGRect(x: Double(index) * chartWidth / gridCount,
                       y: chartWidth,
                       width: labelWidth,
                       height: labelHeight))
            
            label.textAlignment = .left
            
            label.textColor = UIColor.white
            
            if index == 0 {
                
                label.text = "09"
                
            } else {
                
                label.text = "\(index + 9)"
                
            }
            
            chartBackgroundView.addSubview(label)
            
        }

    }
    
    
    func drawGrid() {
        
        for index in stride(from: 0, to: 10, by: 2) {
            let shapeLayer = ShapeLayerManager.setShapeLayer(strokeColor: CGColor.gray, layerFrame: chartBackgroundView.frame)
            let path = UIBezierPath()
            
            path.transCoMove(to: CGPoint(x: chartWidth * Double(index) / 9, y: 0))
            path.transCoAddLine(to: CGPoint(x: chartWidth * Double(index) / 9, y: chartWidth))
            
            ShapeLayerManager.addShapeLayer(shapeLayer: shapeLayer, bezierPath: path, view: chartBackgroundView)
        }
        
        let shapeLayer = ShapeLayerManager.setShapeLayer(strokeColor: CGColor.gray, layerFrame: chartBackgroundView.frame)
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: chartWidth - xPoint, y: -yPoint))
        path.addLine(to: CGPoint(x: chartWidth - xPoint, y: chartHeight - yPoint))
        
        ShapeLayerManager.addShapeLayer(shapeLayer: shapeLayer, bezierPath: path, view: chartBackgroundView)
    
        for index in 0...indexCount {
            let shapeLayer = ShapeLayerManager.setShapeLayer(strokeColor: CGColor.gray, layerFrame: chartBackgroundView.frame)
            let path = UIBezierPath()
            
            
            
            path.transCoMove(to: CGPoint(x: 0, y: chartWidth * Double(index) / Double(indexCount)))
            path.transCoAddLine(to: CGPoint(x: chartWidth, y: chartWidth * Double(index) / Double(indexCount)))
            
            ShapeLayerManager.addShapeLayer(shapeLayer: shapeLayer, bezierPath: path, view: chartBackgroundView)
        }
    }
    
    func setChartView() {
        var tempX = Double()
        var tempY = Double()
        let shapeLayer = ShapeLayerManager.setShapeLayer(strokeColor: CGColor.gray, fillColor: CGColor.redAlpha, layerFrame: chartBackgroundView.frame)
        let path = UIBezierPath()
      
        path.transCoMove(to: CGPoint(x: 2, y: chartWidth / 2))
        for index in tickC.indices {
            tempX = Double(tickT[index]) *  chartWidth / Double(tickT.last!)
            tempY = (Double(tickC[index] - c)) * chartWidth / (c * 0.1 * 2) + chartWidth / 2
            path.transCoAddLine(to: CGPoint(x: tempX + 2, y: tempY))
        }

        path.transCoAddLine(to: CGPoint(x: chartWidth, y: chartWidth / 2))
        
        ShapeLayerManager.addShapeLayer(shapeLayer: shapeLayer, bezierPath: path, view: chartBackgroundView)
        
    }
    
    func setMaxChartView() {
        var tempX = Double()
        var tempY = Double()
        let shapeLayer = ShapeLayerManager.setShapeLayer(strokeColor: CGColor.red, layerFrame: chartBackgroundView.frame)
        let path = UIBezierPath()
        guard let maxValue = tickH.max(), let maxIndex: Int = tickH.firstIndex(of: maxValue) else { return }
        
        path.transCoMove(to: CGPoint(x: 2, y: chartWidth / 2))

        tempX = Double(maxIndex)
        tempY = (Double(maxValue - c)) * chartWidth / (c * 0.1 * 2) + chartWidth / 2
        path.transCoAddLine(to: CGPoint(x: tempX + 2, y: tempY))
        
        ShapeLayerManager.addShapeLayer(shapeLayer: shapeLayer, bezierPath: path, view: chartBackgroundView)
        
        let label = UILabel(frame: CGRect(x: tempX + 2, y: chartWidth / 2 - 70, width: 150, height: 22))
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.text = String(maxValue)
        chartBackgroundView.addSubview(label)

    }
    
    func setMinChartView() {
        var tempX = Double()
        var tempY = Double()
        let shapeLayer = ShapeLayerManager.setShapeLayer(strokeColor: CGColor.green, layerFrame: chartBackgroundView.frame)
        let path = UIBezierPath()
        guard let minValue = tickL.min(), let minIndex: Int = tickL.firstIndex(of: minValue) else { return }
        
        path.transCoMove(to: CGPoint(x: Double(minIndex) * chartWidth / Double(tickT.last!) + 2, y: chartWidth / 2))
        tempX = Double(minIndex) * chartWidth / Double(tickT.last!)
        tempY = (Double(minValue - c)) * chartWidth / (c * 0.1 * 2) + chartWidth / 2
        path.transCoAddLine(to: CGPoint(x: tempX + 2, y: tempY))
        
        ShapeLayerManager.addShapeLayer(shapeLayer: shapeLayer, bezierPath: path, view: chartBackgroundView)
        
        let label = UILabel(frame: CGRect(x: tempX + 2, y: chartWidth / 2 + 10 , width: 150, height: 22))
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.text = String(minValue)
        chartBackgroundView.addSubview(label)

    }
    
    func drawBarGrid() {
        
        for index in stride(from: 0, to: 10, by: 2) {
            let shapeLayer = ShapeLayerManager.setShapeLayer(strokeColor: CGColor.gray, layerFrame: chartBackgroundView.frame)
            let path = UIBezierPath()
            
            path.move(to: CGPoint(x: barWidth * Double(index) / 9 - barXPoint, y: -barYPoint + barHeight))
            path.addLine(to: CGPoint(x: barWidth * Double(index) / 9 - barXPoint, y: -barYPoint + barHeight * 2))
            
            ShapeLayerManager.addShapeLayer(shapeLayer: shapeLayer, bezierPath: path, view: barChartBackgroundView)
        }
        
        let shapeLayer = ShapeLayerManager.setShapeLayer(strokeColor: CGColor.gray, layerFrame: barChartBackgroundView.frame)
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: barWidth - barXPoint, y: -barYPoint))
        path.addLine(to: CGPoint(x: barWidth - barXPoint, y: barHeight - barYPoint))
        
        ShapeLayerManager.addShapeLayer(shapeLayer: shapeLayer, bezierPath: path, view: barChartBackgroundView)
        
        for index in 0...3 {
            let shapeLayer = ShapeLayerManager.setShapeLayer(strokeColor: CGColor.gray, layerFrame: barChartBackgroundView.frame)
            let path = UIBezierPath()
            
            path.move(to: CGPoint(x: 0 - barXPoint, y: (barHeight * Double(index) / 3 ) - barYPoint))
            path.addLine(to: CGPoint(x: barWidth - barXPoint, y: (barHeight * Double(index) / 3 ) - barYPoint))
            
            ShapeLayerManager.addShapeLayer(shapeLayer: shapeLayer, bezierPath: path, view: barChartBackgroundView)
        }
    }
    
    func setBarChartView() {
//        let shapeLayer = ShapeLayerManager.setShapeLayer(strokeColor: CGColor.blue, layerFrame: barChartBackgroundView.frame)
//        let path = UIBezierPath()
//        
////        path.transCoMove(to: CGPoint(x: 0, y: 0))
//        path.move(to: CGPoint(x: -barXPoint, y: -barYPoint))
//        for index in tickV.indices {
//            let lineX = Double(tickT[index]) *  barWidth / Double(tickT.last!)
//            let lineY = (Double(tickV[index])) * barWidth / (c * 0.1 * 2) + barWidth / 2
//            path.transCoAddLine(to: CGPoint(x: lineX + 2, y: lineY))
//        }
//        
//        path.addLine(to: CGPoint(x: barWidth - barXPoint, y: barHeight - barYPoint))
//        
//        ShapeLayerManager.addShapeLayer(shapeLayer: shapeLayer, bezierPath: path, view: barChartBackgroundView)
        
    }


}

extension UIBezierPath {
    
    func transCoMove(to: CGPoint, y: CGFloat = CGFloat(UIScreen.chartWidth)) {
        
        self.move(to: CGPoint(x: to.x - 50, y: y - to.y - 100))
    }
    
    func transCoAddLine(to: CGPoint, y: CGFloat = CGFloat(UIScreen.chartWidth)) {
        
        self.addLine(to: CGPoint(x: to.x - 50, y: y - to.y - 100))
        
    }
}
