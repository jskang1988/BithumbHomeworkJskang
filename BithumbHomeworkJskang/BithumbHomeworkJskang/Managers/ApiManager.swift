//
//  ApiManager.swift
//  BithumbHomeworkJskang
//
//  Created by 강진석 on 2021/03/01.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiManager {
    static let shared = ApiManager()
    private init() {}
    
    /*
     코인원 사의 오픈 API 사용
     */
    
    // 코인 목록을 받아옴
    func getCoinList(completion: @escaping ([CoinData]?) -> Void) {
        AF.request("https://api.coinone.co.kr/ticker_utc?currency=all", method: .get, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
                    case .success(let result):
                        let json = JSON(result)
                        if let jDic = json.dictionary {
                            var coinList = [CoinData].init()
                            for (_, value) in jDic {
                                if let coinDic = value.dictionary {
                                    let coinData = self.convertToCoinDataFromDic(dic: coinDic)
                                    coinList.append(coinData)
                                }
                               
                            }
                            completion(coinList)
                        }
                        else {
                            completion(nil)
                        }
                    
                    case .failure(let error):
                        completion(nil)
                        print(error)
                }
            }
    }
    
    // 특정 코인 정보를 가져옴
    func getCoinByCurrency(currency:String, completion: @escaping (CoinData?) -> Void) {
        AF.request("https://api.coinone.co.kr/ticker_utc?currency=\(currency)", method: .get, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
                    case .success(let result):
                        let json = JSON(result)
                        if let jDic = json.dictionary {
                            let coinData = self.convertToCoinDataFromDic(dic: jDic)
                            completion(coinData)
                        }
                        else {
                            completion(nil)
                        }
                    
                    case .failure(let error):
                        completion(nil)
                        print(error)
                }
            }
    }
    
    func convertToCoinDataFromDic(dic:[String:JSON]) -> CoinData {
        let currency = dic["currency"]?.string ?? ""
        let koreanName = DataManager.shared.getCurrencyKoreanName(currency: currency)
        let volumn = Double.init(dic["volume"]?.string ?? "0") ?? 0
        let high = Double.init(dic["high"]?.string ?? "0") ?? 0
        let low = Double.init(dic["low"]?.string ?? "0") ?? 0
        let first = Double.init(dic["first"]?.string ?? "0") ?? 0
        let last = Double.init(dic["last"]?.string ?? "0") ?? 0
        let yesterdayVolumn = Double.init(dic["yesterday_volume"]?.string ?? "0") ?? 0
        let yesterdayHigh = Double.init(dic["yesterday_high"]?.string ?? "0") ?? 0
        let yesterdayLow = Double.init(dic["yesterday_low"]?.string ?? "0") ?? 0
        let yesterdayFirst = Double.init(dic["yesterday_first"]?.string ?? "0") ?? 0
        let yesterdayLast = Double.init(dic["yesterday_last"]?.string ?? "0") ?? 0
        let changePercent = ((last - yesterdayLast) / yesterdayLast) * 100
        
        let coinData = CoinData.init(currency: currency,
                      koreanName: koreanName,
                      volumn: volumn,
                      high: high,
                      low: low,
                      first: first,
                      last: last,
                      yesterdayVolumn: yesterdayVolumn,
                      yesterdayHigh: yesterdayHigh ,
                      yesterdayLow: yesterdayLow,
                      yesterdayFirst: yesterdayFirst,
                      yesterdayLast: yesterdayLast,
                      changePercent: changePercent)
        
        return coinData
    }
}
