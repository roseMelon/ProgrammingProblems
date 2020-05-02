//
//  FunctionDevelopment.swift
//  ProgrammingProblems
//
//  Copyright © 2020 roseMelon. All rights reserved.
//

/*
 Stack & Queue / 기능 개발 (Function development)
 Problem from https://programmers.co.kr/learn/courses/30/lessons/42586

 solution([93,30,55], [1,30,5]) // [2,1]
*/

import Foundation

func solution(_ progresses:[Int], _ speeds:[Int]) -> [Int] {
    return progresses.enumerated().map { index, element in
        return Int(floor(Double((100 - element)) / Double(speeds[index])))
    }.release()
}

extension Array where Element == Int {
 
    func release() -> [Int] {
        var before: Int = 0
        var tmp: Int = 1
        var result: [Int] = []
        
        self.enumerated().forEach { index, element in
            if index == 0 { before = element; return }
            
            if before >= element {
                tmp += 1
            }else {
                result.append(tmp)
                tmp = 1
                before = element
            }
            
            if index == self.count - 1 { result.append(tmp) }
        }
        return result
    }
}
