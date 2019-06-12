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
    let barYPoint = 100.0 + UIScreen.chartWidth + 10
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
        setBarYLabel()

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
    
    
    func drawGrid() {
        
        for index in stride(from: 0, to: 9, by: 2) {
            let shapeLayer = ShapeLayerManager.setShapeLayer(strokeColor: CGColor.gray, layerFrame: chartBackgroundView.frame)
            let path = UIBezierPath()
            
            path.tMove(to: CGPoint(x: chartWidth * Double(index) / 9, y: 0), xPoint: CGFloat(xPoint), yPoint: CGFloat(yPoint))
            path.tAddLine(to: CGPoint(x: chartWidth * Double(index) / 9, y: chartWidth), xPoint: CGFloat(xPoint), yPoint: CGFloat(yPoint))
            
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
            
            
            
            path.tMove(to: CGPoint(x: 0, y: chartWidth * Double(index) / Double(indexCount)), xPoint: CGFloat(xPoint), yPoint: CGFloat(yPoint))
            path.tAddLine(to: CGPoint(x: chartWidth, y: chartWidth * Double(index) / Double(indexCount)), xPoint: CGFloat(xPoint), yPoint: CGFloat(yPoint))
            
            ShapeLayerManager.addShapeLayer(shapeLayer: shapeLayer, bezierPath: path, view: chartBackgroundView)
        }
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
                CGRect(x: Double(index) * barWidth / gridCount,
                       y: barHeight,
                       width: labelWidth,
                       height: labelHeight))
            
            label.textAlignment = .left
            
            label.textColor = UIColor.white
            
            if index == 0 {
                
                label.text = "09"
                
            } else {
                
                label.text = "\(index + 9)"
                
            }
            
            barChartBackgroundView.addSubview(label)
            
        }

    }
    
    func setChartView() {
        var tempX = Double()
        var tempY = Double()
        let shapeLayer = ShapeLayerManager.setShapeLayer(strokeColor: CGColor.red, fillColor: CGColor.redAlpha, layerFrame: chartBackgroundView.frame)
        let path = UIBezierPath()
      
        path.tMove(to: CGPoint(x: 0, y: chartWidth / 2), xPoint: CGFloat(xPoint), yPoint: CGFloat(yPoint))
        for index in tickC.indices {
            tempX = Double(tickT[index]) *  chartWidth / Double(tickT.last!)
            tempY = (Double(tickC[index] - c)) * chartWidth / (c * 0.1 * 2) + chartWidth / 2
            path.tAddLine(to: CGPoint(x: tempX, y: tempY), xPoint: CGFloat(xPoint), yPoint: CGFloat(yPoint))
        }

        path.tAddLine(to: CGPoint(x: chartWidth, y: chartWidth / 2), xPoint: CGFloat(xPoint), yPoint: CGFloat(yPoint))
        
        ShapeLayerManager.addShapeLayer(shapeLayer: shapeLayer, bezierPath: path, view: chartBackgroundView)
        
    }
    
    func setMaxChartView() {
        var tempX = Double()
        var tempY = Double()
        let shapeLayer = ShapeLayerManager.setShapeLayer(strokeColor: CGColor.red, layerFrame: chartBackgroundView.frame)
        let path = UIBezierPath()
        guard let maxValue = tickH.max(), let maxIndex: Int = tickH.firstIndex(of: maxValue) else { return }
        
        path.tMove(to: CGPoint(x: 2, y: chartWidth / 2), xPoint: CGFloat(xPoint), yPoint: CGFloat(yPoint))

        tempX = Double(maxIndex)
        tempY = (Double(maxValue - c)) * chartWidth / (c * 0.1 * 2) + chartWidth / 2
        path.tAddLine(to: CGPoint(x: tempX + 2, y: tempY), xPoint: CGFloat(xPoint), yPoint: CGFloat(yPoint))
        
        ShapeLayerManager.addShapeLayer(shapeLayer: shapeLayer, bezierPath: path, view: chartBackgroundView)
        
        let label = UILabel(frame: CGRect(x: tempX, y: chartWidth / 2 - 70, width: 150, height: 22))
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
        
        path.tMove(to: CGPoint(x: Double(minIndex) * chartWidth / Double(tickT.last!) + 2, y: chartWidth / 2), xPoint: CGFloat(xPoint), yPoint: CGFloat(yPoint))
        tempX = Double(minIndex) * chartWidth / Double(tickT.last!)
        tempY = (Double(minValue - c)) * chartWidth / (c * 0.1 * 2) + chartWidth / 2
        path.tAddLine(to: CGPoint(x: tempX + 2, y: tempY), xPoint: CGFloat(xPoint), yPoint: CGFloat(yPoint))
        
        ShapeLayerManager.addShapeLayer(shapeLayer: shapeLayer, bezierPath: path, view: chartBackgroundView)
        
        let label = UILabel(frame: CGRect(x: tempX, y: chartWidth / 2 + 10 , width: 150, height: 22))
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.text = String(minValue)
        chartBackgroundView.addSubview(label)

    }
    
    func drawBarGrid() {
        
        for index in stride(from: 0, to: 9, by: 2) {
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
        let shapeLayer = ShapeLayerManager.setShapeLayer(strokeColor: CGColor.blue, layerFrame: barChartBackgroundView.frame)
        let path = UIBezierPath()
        for index in tickT.indices {
            path.move(to: CGPoint(x: -barXPoint + Double(index) * barWidth / Double(tickT.count), y: barHeight - barYPoint))
            path.addLine(to: CGPoint(x:  -barXPoint + Double(index) * barWidth / Double(tickT.count), y: barHeight - barYPoint - (tickV[index] / tickV.max()! * barHeight)))
        }
        
        ShapeLayerManager.addShapeLayer(shapeLayer: shapeLayer, bezierPath: path, view: barChartBackgroundView)

    }
    
    func setBarYLabel() {
        
        for index in 0...2 {
            
            let former = barHeight * Double(index) / Double(3)
            
            let latter = Double(index) * labelHeight / Double(3)
            
            let label = UILabel(frame: CGRect(x: -barXPoint, y: former - latter, width: labelWidth, height: labelHeight))
            
            guard let maxValue = tickV.max() else { return }
            
            switch index {
                
            case 0:
                label.setBarYLabelStlye(item: maxValue / 3 * 3, bgColor: UIColor.clear, textColor: UIColor.white)
            case 1:
                label.setBarYLabelStlye(item: maxValue / 3 * 2, bgColor: UIColor.clear, textColor: UIColor.white)
            case 2:
                label.setBarYLabelStlye(item: maxValue / 3 * 1, bgColor: UIColor.clear, textColor: UIColor.white)
            default:
                label.text = "N/A"
                
            }
            
            label.textAlignment = .right
            
            barChartBackgroundView.addSubview(label)
        }
        
    }



}

extension UIBezierPath {
    
    func tMove(to: CGPoint, y: CGFloat = CGFloat(UIScreen.chartWidth), xPoint: CGFloat, yPoint: CGFloat) {
        
        self.move(to: CGPoint(x: to.x - xPoint, y: y - to.y - yPoint))
    }
    
    func tAddLine(to: CGPoint, y: CGFloat = CGFloat(UIScreen.chartWidth), xPoint: CGFloat, yPoint: CGFloat) {
        
        self.addLine(to: CGPoint(x: to.x - xPoint, y: y - to.y - yPoint))
        
    }
    
    
}
