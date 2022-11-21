//
//  선택5번.swift
//  MyCreditManager
//
//  Created by Hamlit Jason on 2022/11/22.
//

import Foundation

func 선택5번() {
    print(StringSet.선택5번)
    
    // MARK: - Input
    guard let input = readLine(), input.trimmingCharacters(in: .whitespaces).count > 0 else {
        print(StringSet.선택5번_실패_입력이_잘못되었을때)
        return
    }
    
    // MARK: - Logic
    guard let student = students[input] else {
        print(StringSet.선택5번_실패_학생이_없을떄)
        return
    }
    
    print(StringSet.선택5번_성공(student))
}
