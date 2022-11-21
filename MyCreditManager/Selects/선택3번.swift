//
//  선택3번.swift
//  MyCreditManager
//
//  Created by Hamlit Jason on 2022/11/21.
//

import Foundation

func 선택3번() {
    print(StringSet.선택3번)
    
    // MARK: - Input
    guard let inputs = readLine()?.split(separator: " "),
          inputs.count == 3
    else {
        print(StringSet.선택3번_실패)
        return
    }
    
    let name: String = String(inputs[0])
    let subject: String = String(inputs[1])
    let gradeString = String(inputs[2])
    guard let grade = Student.Grade.convertToGarde(gradeString),
          students[name] != nil
    else {
        print(StringSet.선택3번_실패)
        return
    }
    
    // MARK: - Logic
    students[name]!.성적[subject] = grade
    print(name + StringSet.선택3번_성공(subject, gradeString))
}
