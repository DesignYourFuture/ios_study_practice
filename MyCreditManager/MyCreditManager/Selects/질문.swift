//
//  질문.swift
//  MyCreditManager
//
//  Created by Hamlit Jason on 2022/11/22.
//

import Foundation

func 질문() {
    enum 선택타입: String {
        case _1번 = "1"
        case _2번 = "2"
        case _3번 = "3"
        case _4번 = "4"
        case _5번 = "5"
        case 종료 = "X"
    }
    
    // MARK: - Logic
    while true {
        print(StringSet.질문 + "\n" + StringSet.선택옵션)
        let input = readLine()
        
        switch input {
        case 선택타입._1번.rawValue: 선택1번()
        case 선택타입._2번.rawValue: 선택2번()
        case 선택타입._3번.rawValue: 선택3번()
        case 선택타입._4번.rawValue: 선택4번()
        case 선택타입._5번.rawValue: 선택5번()
        case 선택타입.종료.rawValue: return
        default: print("정의하지 않은 input")
        }
    }
    
}
