//
//  BracketsConversion.swift
//  ProgrammingProblems
//
//  Copyright © 2020 roseMelon. All rights reserved.
//
	
/*
 2020 KAKAO BLIND RECRUITMENT / 괄호 변환 (Brackets conversion)
 Problem from https://programmers.co.kr/learn/courses/30/lessons/60058

 solution("(()())()") // "(()())()"
 solution(")(") // "()"
 solution("()))((()") // "()(())()"
*/

import Foundation

func solution(_ p: String) -> String {
    return run(Array(p).map { String($0) })
}

func run(_ s: [String]) -> String {
    
    if s.count == 0 { return "" }
    
    let splited = s.splitBrackets()
    
    return splited.0.checkAvailable()
        ? splited.0.joined() + run(splited.1)
        : "(" + run(splited.1) + ")" + splited.0.removeFirstAndLast().reverseAllBrackets().joined()
}

extension Array where Element == String {
    
    func splitBrackets() -> ([String], [String]) {
        var counter = 0
        var index = 0
        for i in 0..<self.count {
            counter = counter + (self[i] == "(" ? 1 : -1)
            index = i
            if counter == 0 { break }
        }
        return (index == self.count - 1) ? (self, []) : (Array(self[0...index]), Array(self[(index+1)...]))
    }

    func checkAvailable() -> Bool {
        var counter = 0
        for i in 0..<self.count {
            counter = counter + (self[i] == "(" ? 1 : -1)
            if counter < 0 { return false }
        }
        return true
    }
    
    func removeFirstAndLast() -> [String] {
        return (self.count < 3) ? [] : Array(self[1...self.count - 2])
    }
    
    func reverseAllBrackets() -> [String] {
        return self.map { ($0 == ")") ? "(" : ")" }
    }
}
