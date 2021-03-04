//
//  BookmarkUserDefaultManager.swift
//  BithumbHomeworkJskang
//
//  Created by 강진석 on 2021/03/02.
//

import Foundation

class BookmarkUserDefaultManager {
    static let shared = BookmarkUserDefaultManager()
    private init() {}
    
    let BOOKMARK_CURRENCY_DATA_KEY = "BOOKMARK_CURRENCY_DATA_KEY"
    
    // UserDefault에 즐겨찾기 목록 추가
    // 중복저장을 막기위해 Set 자료구조 사용
    func addCurrency(currency:String) {
        var bookmarkArray = UserDefaults.standard.stringArray(forKey: BOOKMARK_CURRENCY_DATA_KEY) ?? [String]()
        var bookmarkSet:Set = Set.init(bookmarkArray)
        bookmarkSet.insert(currency.uppercased())
        bookmarkArray = Array.init(bookmarkSet)
        UserDefaults.standard.setValue(bookmarkArray, forKey: BOOKMARK_CURRENCY_DATA_KEY)
    }
    
    // UserDefault에 즐겨찾기 목록 제거
    func removeCurrency(currency:String) {
        var bookmarkArray = UserDefaults.standard.stringArray(forKey: BOOKMARK_CURRENCY_DATA_KEY) ?? [String]()
        bookmarkArray = bookmarkArray.filter({
            return $0 != currency.uppercased()
        })
        UserDefaults.standard.setValue(bookmarkArray, forKey: BOOKMARK_CURRENCY_DATA_KEY)
    }
    
    // userDefault에 즐겨찾기 여부 확인
    func isExistCurrency(currency:String) -> Bool {
        let bookmarkArray = UserDefaults.standard.stringArray(forKey: BOOKMARK_CURRENCY_DATA_KEY) ?? [String]()
        if bookmarkArray.contains(currency.uppercased()) {
            return true
        }
        return false
    }
}
