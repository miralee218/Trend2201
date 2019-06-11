//
//  ViewController.swift
//  Trend2201
//
//  Created by Mira on 2019/6/10.
//  Copyright © 2019 AppWork. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var root: Trend?
    
    var stk = Int() //商品代碼
    
    var c = Double() //參考價
    
    var tp = Double() //漲停價
    
    var bp = Double() //跌停價
    
    var st = Int() //基準時間
    
    var tickT = [Int]() //時間
    
    var tickC = [Double]() //收價
    
    var tickV = [Int]() //量
    
    var tickH = [Double]() //最高收價
    
    var tickL = [Double]() //最低收價
    
    
    var array1 = [Double]()
    
    var array2 = [Double]()
    
    var array3 = [Double]()
    
    var array4 = [Double]()
    
    var array5 = [Double]()
    

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
            tickH.append(Double(minute.h) ?? 0.0)
            tickL.append(Double(minute.l) ?? 0.0)
        }
        
        print(tickL.min())
        print(tickL.firstIndex(of: tickH.min()!))
//
//        var changeArray = false
//        for i in tickC {
//
//            if i >= c && changeArray == false{
//                array1.append(i)
//            } else {
//                changeArray = true
//            }
//        }
//        tickC.removeFirst(array1.count)
//
//
//        changeArray = false
//        for i in tickC {
//
//            if i <= c && changeArray == false{
//                array2.append(i)
//            } else {
//                changeArray = true
//            }
//        }
//        tickC.removeFirst(array2.count)
//
//
//        changeArray = false
//        for i in tickC {
//
//            if i >= c && changeArray == false{
//                array3.append(i)
//            } else {
//                changeArray = true
//            }
//        }
//
//        tickC.removeFirst(array3.count)
//
//
//        changeArray = false
//        for i in tickC {
//
//            if i <= c && changeArray == false{
//                array4.append(i)
//            } else {
//                changeArray = true
//            }
//        }
//        tickC.removeFirst(array4.count)
//
//        changeArray = false
//        for i in tickC {
//
//            if i >= c && changeArray == false{
//                array5.append(i)
//            } else {
//                changeArray = true
//            }
//        }
//        tickC.removeFirst(array5.count)


    }

}

