//
//  DataProvider.swift
//  Trend2201
//
//  Created by Mira on 2019/6/10.
//  Copyright © 2019 AppWork. All rights reserved.
//

import Foundation

class DataProvider {
    
    static let shared = DataProvider()
    
    private init () {}
    
    func loadData(completion: @escaping (Result<Trend, Error>) -> Void) {

        do {
            let url = Bundle.main.url(forResource: "trend2201", withExtension: "json")!
            let data = try Data(contentsOf: url)
            let result = try JSONDecoder().decode(Trend.self, from: data)
            completion(Result.success(result))

        }
        catch {
            print(error)
            completion(Result.failure(error))

        }
        
        
    }
    
}
