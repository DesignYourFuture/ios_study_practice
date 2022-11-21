//
//  Student.swift
//  MyCreditManager
//
//  Created by Hamlit Jason on 2022/11/21.
//

import Foundation

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
