//
//  SearchingPrimeNumber.swift
//  ProgrammingProblems
//
//  Copyright © 2020 roseMelon. All rights reserved.
//
	
/*
 Practice Problem / 소수 찾기 (Searching prime number)
 Problem from https://programmers.co.kr/learn/courses/30/lessons/12921

 solution([93,30,55], [1,30,5]) // [2,1]
*/

import Foundation

func solution(_ n: Int) -> Int {
    var result = Array.init(repeating: 1, count: n-1)
    
    let sqrtNum = Int(sqrt(Double(n)))
    
    for i in 2...sqrtNum {
        guard result[i-2] != 0 else { continue }
        
        for j in i...n {
            if (j%i == 0 && j != i) { result[j-2] = 0 }
        }
    }
    
    return result.filter { $0 == 1 }.count
}
