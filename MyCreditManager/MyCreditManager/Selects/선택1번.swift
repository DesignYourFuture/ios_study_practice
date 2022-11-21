//
//  Select.swift
//  MyCreditManager
//
//  Created by Hamlit Jason on 2022/11/21.
//

import Foundation

func 선택1번() {
    print(StringSet.선택1번)
    
    // MARK: - Input
    guard let input = readLine(), input.trimmingCharacters(in: .whitespaces).count > 0 else {
        print(StringSet.선택1번_실패)
        return
    }
    
    // MARK: - Logic
    if students[input] == nil {
        students[input] = Student()
        print(input + " " + StringSet.선택1번_성공)
    } else {
        print(input + StringSet.선택1번_중복)
    }
}
