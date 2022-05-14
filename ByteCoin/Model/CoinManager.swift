//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Sai Abhilash Gudavalli on 15/05/22.
//

import Foundation

protocol CoinManagerDelegate {
    func updateData(data: CoinData)
    func didFailWithError(error: Error)
    
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "55D084BA-2E4C-4922-BD1C-3DCA7B51225B"
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let coinData = parseJSON(data: safeData) {
                        delegate?.updateData(data: coinData)
                    }
                }
                
            }
            task.resume()
        }
    }

    
    func parseJSON(data: Data) -> CoinData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            return decodedData
        } catch {
            print("Unable to decode data \(error)")
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
