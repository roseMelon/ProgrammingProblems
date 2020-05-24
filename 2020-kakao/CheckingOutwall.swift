//
//  CheckingOutwall.swift
//  ProgrammingProblems
//
//  Copyright © 2020 roseMelon. All rights reserved.
//
	
/*
 2020 KAKAO BLIND RECRUITMENT / 외벽 점검 (Checking outwall)
 Problem from https://programmers.co.kr/learn/courses/30/lessons/60062

 solution(12, [1, 5, 6, 10], [1, 2, 3, 4]) // 2
 solution(12, [1, 3, 4, 9, 10], [3, 5, 7]) // 1
*/

import Foundation

func solution(_ n:Int, _ weak:[Int], _ dist:[Int]) -> Int {

    var record: [Set<[Int]>] = [[weak]]
    
    let reversedDist: [Int] = dist.reversed()
    
    for count in 1...dist.count {
        if weak.count == count { return count }
        
        let movable = reversedDist[count-1]
        if movable >= n { return 1 }
        
        var newWeak: Set<[Int]> = []
        
        for weakList in record[count-1] {
            for weakIndex in 0..<weakList.count {

                let point = weakList[weakIndex]
                
                let filteredWeak = weakList.filter {
                    return (point - movable < 0)
                        ? !((0...point).contains($0) || ((n + (point - movable))...n).contains($0))
                        : !(((point - movable)...point).contains($0))
                }

                if (filteredWeak.count == 0){ return count }

                newWeak.insert(filteredWeak)
            }
        }

        record.append(newWeak)
    }
    
    return -1
}
