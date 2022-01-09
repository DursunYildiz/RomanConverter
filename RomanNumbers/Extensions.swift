//
//  Extensions.swift
//  RomanNumbers
//
//  Created by A101Mac on 9.01.2022.
//

import Foundation
extension String {
    func convertToRoman() -> String {
        let dictRomanValue: [String: Int] = ["I": 1, "V": 5, "X": 10, "L": 50, "C": 100, "D": 500, "M": 1000, "MM": 2000, "MMM": 3000, "MMMM": 4000]
        var val: Int = 0
        let arrayStr = Array(self)
        for index in 0 ..< arrayStr.count {

            for itemDic in dictRomanValue {
                if String(arrayStr[index]) == itemDic.key {
                   
                    if index + 1 < arrayStr.count {
                        for itemdic2 in dictRomanValue {
                            if String(arrayStr[index + 1]) == itemdic2.key {
                                if itemDic.value < itemdic2.value {
                                    val -= itemDic.value
                                }
                                else {
                                    val += itemDic.value
                                }
                            }
                        }
                    }
                    else {
                        val += itemDic.value
                    }
                }
            }
        }
        
        return String(val)
    }
    func isRoman() -> Bool {
        var isRoman = false
        let myDic = Dictionary(grouping: self, by: { $0 })
        for item in myDic {
            if item.value.count > 3 {
                isRoman = false
             
                
            }
            else  {
                isRoman = true
            }
        
        
    }
        return isRoman
    }
}
