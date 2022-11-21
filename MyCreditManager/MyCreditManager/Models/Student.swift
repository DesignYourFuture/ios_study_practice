//
//  Student.swift
//  MyCreditManager
//
//  Created by Hamlit Jason on 2022/11/21.
//

import Foundation

struct Student {
    var 성적: [String: Grade] = [:]
    
    enum Grade: Float, CaseIterable {
        case aplus = 4.5
        case a0 = 4.0
        case bplus = 3.5
        case b0 = 3.0
        case cplus = 2.5
        case c0 = 2.0
        case dplus = 1.5
        case d0 = 1.0
        case f = 0.0
        
        static func convertToGarde(_ gradeString: String) -> Grade? {
            switch gradeString {
            case "A+": return .aplus
            case "A": return .a0
            case "B+": return .bplus
            case "B": return .b0
            case "C+": return .cplus
            case "C": return .c0
            case "D+": return .dplus
            case "D": return .d0
            case "F": return .f
            default: return nil
            }

        }
        
    }
}
