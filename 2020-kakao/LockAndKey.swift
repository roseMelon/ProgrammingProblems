//
//  LockAndKey.swift
//  ProgrammingProblems
//
//  Copyright © 2020 roseMelon. All rights reserved.
//
	
/*
 2020 KAKAO BLIND RECRUITMENT / 자물쇠와 열쇠 (Lock and Key)
 Problem from https://programmers.co.kr/learn/courses/30/lessons/60059

 solution([[0, 0, 0], [1, 0, 0], [0, 1, 1]], [[1, 1, 1], [1, 1, 0], [1, 0, 1]]) // true
*/

import Foundation

var LOCK: [[Int]] = []
var map: [[Int]] = []

func solution(_ key:[[Int]], _ lock:[[Int]]) -> Bool {
    
    guard 3 <= key.count && key.count <= 20
        && 3 <= lock.count && lock.count <= 20
        && key.count <= lock.count
        else { return false }
            
    if (lock.reduce([]) { $0 + $1 }.filter { $0 == 0 }.count == 0) { return true }
    
    LOCK = lock
    let mapLength = key.count - 2 + (lock.count * 2)
    map = .init(repeating: .init(repeating: 0, count: mapLength), count: mapLength)
    
    // Set key to large map
    for x in 0..<key.count {
        for y in 0..<key.count {
            map[x+lock.count-1][y+lock.count-1] = key[x][y]
        }
    }
    
    // Start point
    for x in 0...mapLength - lock.count{
        for y in 0...mapLength - lock.count {
            if unlockCheck(x, y) { return true }
        }
    }
    
    return false
}

func unlockCheck(_ x: Int, _ y: Int) -> Bool {
    var state = [true, true, true, true]
    
    for a in 0..<LOCK.count{
        for b in 0..<LOCK.count{
            guard state.contains(true) else { return false }
            
            // lock 0 (a, b)
            if state[0] == true {
                state[0] = state[0] && map[x+a][y+b] + LOCK[a][b] == 1
            }
            // lock 90 (b, max - a)
            if state[1] == true {
                state[1] = state[1] && map[x+a][y+b] + LOCK[b][(LOCK.count-1)-a] == 1
            }
            // lock 180 (max - a, max - b)
            if state[2] == true {
                state[2] = state[2] && map[x+a][y+b] + LOCK[(LOCK.count-1)-a][(LOCK.count-1)-b] == 1
            }
            // lock 270 (max - b, a)
            if state[3] == true {
                state[3] = state[3] && map[x+a][y+b] + LOCK[(LOCK.count-1)-b][a] == 1
            }
        }
    }
    
    return state.contains(true)
}
