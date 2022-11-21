//
//  선택4번.swift
//  MyCreditManager
//
//  Created by Hamlit Jason on 2022/11/22.
//

import Foundation

func 선택4번() {
    print(StringSet.선택4번)
    
    // MARK: - Input
    guard let inputs = readLine()?.split(separator: " "),
          inputs.count == 2
    else {
        print(StringSet.선택4번_실패_입력이_잘못되었을때)
        return
    }
    
    // MARK: - Logic
    let name = String(inputs[0])
    let subject = String(inputs[1])
    
    if students[name] != nil {
        if students[name]!.성적[subject] != nil {
            print(StringSet.선택4번_성공(name, subject))
            students[name]!.성적[subject] = nil
        } else {
            print(StringSet.선택4번_실패_과목이_없을떄)
        }
    } else {
        print(StringSet.선택4번_실패_학생이_없을떄)
    }
}
