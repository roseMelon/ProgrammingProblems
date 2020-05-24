//
//  FailureRate.swift
//  ProgrammingProblems
//
//  Copyright © 2020 roseMelon. All rights reserved.
//
	
/*
 2019 KAKAO BLIND RECRUITMENT / 실패율 (Failure rate)
 Problem from https://programmers.co.kr/learn/courses/30/lessons/42889

 solution(5, [2,1,2,6,2,4,3,3]) // [3,4,2,1,5]
 solution(4, [4,4,4,4,4]) // [4,1,2,3]
*/

import Foundation

func solution(_ N:Int, _ stages:[Int]) -> [Int] {

    var rates: [Double] = .init(repeating: 0, count: N)
    
    var userStages: [Int: Int] = [:]
    
    stages.forEach {
        if let value = userStages[$0] { userStages[$0] = value + 1 }
        else { userStages[$0] = 1 }
    }
    
    var user = stages.count
    
    userStages.keys.sorted().forEach {
        guard let value = userStages[$0], $0 <= N else { return }
        rates[$0-1] = Double(value) / Double(user)
        user -= value
    }
    
    return rates.enumerated().sorted { $0.element > $1.element }.map { $0.offset + 1 }
}
