//
//  GridView.swift
//  Trend2201
//
//  Created by Mira on 2019/6/11.
//  Copyright © 2019 AppWork. All rights reserved.
//

import UIKit

class GridView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        Bundle.main.loadNibNamed("GridView", owner: self, options: nil)
//        addSubview(containerView)
    }
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }

}
