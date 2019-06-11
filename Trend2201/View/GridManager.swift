//
//  GridManager.swift
//  Trend2201
//
//  Created by Mira on 2019/6/11.
//  Copyright © 2019 AppWork. All rights reserved.
//

import UIKit

class GridManager {
    static func getYAxisCount(allTime: [Int]) -> Int {
        let totalTime = allTime.count.quotientAndRemainder(dividingBy: 60)
        if totalTime.remainder > 0 {
            return totalTime.quotient + 1
        } else {
            return totalTime.quotient
        }
    }
}
