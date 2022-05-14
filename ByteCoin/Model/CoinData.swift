//
//  CoinData.swift
//  ByteCoin
//
//  Created by Sai Abhilash Gudavalli on 15/05/22.
//

import Foundation

struct CoinData: Codable {
    let rate: Double
    let asset_id_base: String
    let asset_id_quote: String
    
    
    func getFormattedCurrencyRate() -> String {
        return String(format: "%.2f", rate)
    }
}
