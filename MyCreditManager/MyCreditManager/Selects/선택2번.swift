//
//  선택2번.swift
//  MyCreditManager
//
//  Created by Hamlit Jason on 2022/11/21.
//

import Foundation

func 선택2번() {
    print(StringSet.선택2번)
    
    // MARK: - Input
    let input = readLine() ?? ""
    
    // MARK: - Logic
    guard let index = students.firstIndex(where: { student in
        student.이름 == input
    }) else {
        print(input + " " + StringSet.선택2번_실패)
        return
    }
                                          
    students.remove(at: index)
    print(input + " " + StringSet.선택2번_성공)
}
