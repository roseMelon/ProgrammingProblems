//
//  StringCompression.swift
//  ProgrammingProblems
//
//  Copyright © 2020 roseMelon. All rights reserved.
//
	
/*
 2020 KAKAO BLIND RECRUITMENT / 문자열 압축 (String compression)
 Problem from https://programmers.co.kr/learn/courses/30/lessons/60057

 solution("a") // 1
 solution("aabbaccc") // 7
 solution("ababcdcdababcdcd") // 9
 solution("abcabcdede") // 8
 solution("abcabcabcabcdededededede") // 14
 solution("xababcdcdababcdcd") // 17
*/

import Foundation

func solution(_ s: String) -> Int {
    
    if s.count == 1 { return 1 }

    var min = s.count
    
    for count in 1...Int(floor(Double(s.count)/2.0)) {
        var splitedString: [String] = []
    
        let last = Array(s).map { String($0) }.enumerated()
            .reduce("") { result, data -> String in
                if data.offset % count == 0 && data.offset != 0 {
                    splitedString.append(result)
                    return data.element
                }
                return result + data.element
            }
        
        splitedString.append(last)
                
        var result: String = ""
        var tmp: String = ""
        var counter: Int = 1
        
        splitedString.enumerated().forEach { data in
            if data.offset == 0 { tmp = data.element; return }
            if tmp == data.element { counter += 1; return }
            result += ((counter == 1) ? "" : String(counter)) + tmp
            tmp = data.element
            counter = 1
        }
        result += ((counter == 1) ? "" : String(counter)) + tmp
                
        min = (result.count < min) ? result.count : min
    }
    return min
}
