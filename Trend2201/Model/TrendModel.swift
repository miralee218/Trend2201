//
//  TrendModel.swift
//  Trend2201
//
//  Created by Mira on 2019/6/10.
//  Copyright © 2019 AppWork. All rights reserved.
//

import Foundation

struct Trend: Codable {

    let root: TrendData
    
    struct TrendData: Codable {
        
        let stk: String //商品代碼
        
        let c: String //參考價
        
        let tp: String //漲停價
        
        let bp: String //跌停價
        
        let st: String //基準時間
        
        let tick: [Tick] //走勢列表
        
    }
    
    struct Tick: Codable {
        
        let t: String //時間
        
        let c: String //收價
        
        let v: String //量
        
    }

}








