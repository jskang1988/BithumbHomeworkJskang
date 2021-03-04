//
//  CoinData.swift
//  BithumbHomeworkJskang
//
//  Created by 강진석 on 2021/03/02.
//

import Foundation

struct CoinData: Codable {
    let currency: String // 암호화폐명 Ex) btc
    let koreanName: String // 한국어 암호화폐명 Ex) 비트코인
    
    let volumn: Double // 거래량
    let high: Double // 오늘 고점가
    let low : Double // 오늘 저점가
    let first: Double // 오늘 시가
    let last: Double // 현재가
    
    let yesterdayVolumn: Double // 어제 거래량
    let yesterdayHigh: Double // 어제 고점가
    let yesterdayLow: Double // 어제 저점가
    let yesterdayFirst: Double // 어제 시가
    let yesterdayLast: Double // 어제 종가
    
    let changePercent: Double // 등락률(%)
    
}
