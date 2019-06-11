//
//  LineChart.swift
//  Trend2201
//
//  Created by Mira on 2019/6/11.
//  Copyright © 2019 AppWork. All rights reserved.
//

import UIKit

class LineChart: UIView {
    var chartBackgroundView = UIView()
    let chartWidth = UIScreen.chartWidth
    let chartHeight = UIScreen.chartWidth
    let xPonit = 50.0
    let yPonit = 100.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        chartBackgroundView = UIView(frame: CGRect(x: xPonit, y: yPonit, width: chartWidth, height: chartHeight))
        
        chartBackgroundView.backgroundColor = .white
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
