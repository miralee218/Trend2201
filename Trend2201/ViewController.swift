//
//  ViewController.swift
//  Trend2201
//
//  Created by Mira on 2019/6/10.
//  Copyright © 2019 AppWork. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var root: Root?
    
    var stk = Int() //商品代碼
    
    var c = Double() //參考價
    
    var tp = Double() //漲停價
    
    var bp = Double() //跌停價
    
    var st = Int() //基準時間
    
    var tickT = [Int]() //時間
    
    var tickC = [Double]() //收價
    
    var tickV = [Int]() //量

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DataProvider.shared.loadData(completion: {result in
            switch result{
            case .success(let root):
                self.root = root
            case .failure(let error):
                print(error)
            }
        })
        
        guard let root = root else { return }
        self.stk = Int(root.root.stk) ?? 0
        self.c = Double(root.root.c) ?? 0.0
        self.tp = Double(root.root.tp) ?? 0.0
        self.bp = Double(root.root.bp) ?? 0.0
        self.st = Int(root.root.st) ?? 0
        
        for minute in root.root.tick{
            tickT.append(Int(minute.t) ?? 0)
            tickC.append(Double(minute.c) ?? 0.0)
            tickV.append(Int(minute.v) ?? 0)
        }

        
        print(self.stk, c, tp, bp, st,tickV, tickT, tickC)

    }

    

        
    

}

