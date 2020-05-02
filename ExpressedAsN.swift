//
//  ExpressedAsN.swift
//  ProgrammingProblems
//
//  Copyright © 2020 roseMelon. All rights reserved.
//

/*
 Dynamic Programming / N으로 표현 (Expressed as N)
 Problem from https://programmers.co.kr/learn/courses/30/lessons/42895

 solution(5, 12) // 4
 solution(2, 11) // 3
*/

import Foundation

func solution(_ N:Int, _ number:Int) -> Int {
    if N == number { return 1 }
    return step(state: [[],[N],[justNumber(N, reapeat: 2), N*N, N+N, 1]], N: N, counter: 2, Number: number)
}

func step(state: [Set<Int>], N: Int, counter: Int, Number: Int) -> Int {
    if counter > 8 { return -1 }
    if let last = state.last, last.contains(Number) { return counter }
    
    var newState: Set<Int> = [justNumber(N, reapeat: counter + 1)]
        
    for i in 1..<counter+1 {
        state[i].forEach { x in
            state[counter+1 - i].forEach { y in
                let newValues = [x+y, x-y, x/y, x*y]
                                
                newValues.forEach { new in
                    guard new != 0 else { return }
                    newState.insert(new)
                }
            }
        }
    }
    return step(state: state + [newState], N: N, counter: counter + 1, Number: Number)
}

func justNumber(_ N: Int, reapeat: Int) -> Int {
    return Int(String(repeating: String(N), count: reapeat))!
}

