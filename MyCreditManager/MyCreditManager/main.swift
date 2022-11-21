//
//  main.swift
//  MyCreditManager
//
//  Created by Hamlit Jason on 2022/11/21.
//

import Foundation

func 질문() {
    enum 선택타입: String {
        case _1번 = "1"
        case _2번 = "2"
        case 종료 = "X"
    }
    
    // MARK: - Logic
    while true {
        print(StringSet.질문 + "\n" + StringSet.선택옵션)
        let input = readLine()
        
        switch input {
        case 선택타입._1번.rawValue: 선택1번()
        case 선택타입._2번.rawValue: 선택2번()
        case 선택타입.종료.rawValue: return
        default: print("정의하지 않은 input")
        }
    }
    
}

print("Hello World")

// MARK: - Properties
var students: [Student] = [] {
    didSet { print("💕 \(students)")}
}

질문()
print(StringSet.종료)
