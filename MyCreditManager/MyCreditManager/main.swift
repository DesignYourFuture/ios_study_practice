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
        case 종료 = "X"
    }
    
    // MARK: - Properties
    var students: [Student] = [] {
        didSet { print("💕 \(students)")}
    }
    
    // MARK: - Logic
    print(StringSet.질문 + "\n" + StringSet.선택옵션)
    let input = readLine().map { $0 }
    
    switch input {
    case 선택타입._1번.rawValue: 선택1번(&students)
    case 선택타입.종료.rawValue: print(StringSet.종료)
    default: print("정의하지 않은 input")
    }
}

func 선택1번(_ students: inout [Student]) {
    print(StringSet.선택1번)
    
    print("🐻‍❄️ \(students)")
    guard let input = readLine(), input.trimmingCharacters(in: .whitespaces).count > 0 else {
        print(StringSet.선택1번_오류)
        질문()
        return
    }
    
    if students.contains(where: { student in
        student.이름 == input
    }) {
        print(input + StringSet.선택1번_중복)
    } else {
        students.append(Student(이름: input))
        print(input + " " + StringSet.선택1번_완료)
    }
    print("🐻‍❄️ \(students)")
    질문()
}

struct Student {
    var 이름: String
    var 성적: [String: Grade] = [:]
    
    enum Grade: Float {
        case aplus = 4.5
        case a0 = 4.0
        case bplus = 3.5
        case b0 = 3.0
        case cplus = 2.5
        case c0 = 2.0
        case dplus = 1.5
        case d0 = 1.0
        case f = 0.0
    }
}

struct StringSet {
    // MARK: - excute
    static let 질문 = "원하는 기능을 입력해주세요."
    static let 선택옵션 = "1: 학생추가, 2: 학생삭제, 3: 성정추가(변경), 4: 성적삭제:, 5: 평점보기, X: 종료"
    static let 잘못된선택 = "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요."
    
    // MARK: - 종료
    static let 종료 = "프로그램을 종료합니다..."
    
    // MARK: - 선택 1번
    static let 선택1번 = "추가할 학생의 이름을 입력해주세요."
    static let 선택1번_완료 = "학생을 추가했습니다."
    static let 선택1번_중복 = "은 이미 존재하는 학생입니다. 추가하지 않습니다."
    static let 선택1번_오류 = "입력이 잘못 되었습니다. 다시 확인해주세요."
    
    
}

print("Hello World")
질문()
