//
//  OpenChat.swift
//  ProgrammingProblems
//
//  Copyright © 2020 roseMelon. All rights reserved.
//
	
/*
 2019 KAKAO BLIND RECRUITMENT / 오픈채팅방 (Open chat)
 Problem from https://programmers.co.kr/learn/courses/30/lessons/42888?language=swift

 solution(["Enter uid1234 Muzi", "Enter uid4567 Prodo","Leave uid1234","Enter uid1234 Prodo","Change uid4567 Ryan"]) // ["Prodo님이 들어왔습니다.", "Ryan님이 들어왔습니다.", "Prodo님이 나갔습니다.", "Prodo님이 들어왔습니다."]
*/

import Foundation

func solution(_ record:[String]) -> [String] {
    
    var nickname: [String: String] = [:]

    let seperate = record.map { $0.split(separator: " ").map { String($0) } }
    
    return seperate
        .map { log -> (Moving, String)? in
            switch log[0] {
            case "Enter":
                nickname[log[1]] = log[2]
                return(.enter, log[1])
                
            case "Leave":
                return (.leave, log[1])
                
            case "Change":
                nickname[log[1]] = log[2]
                return nil
            default :
                return nil
            }
        }.filter { $0 != nil }.map { $0! }
        .map { (nickname[$0.1] ?? "") + $0.0.print }
}

enum Moving {
    case enter, leave
    
    var print: String { return (self == .enter) ? "님이 들어왔습니다." : "님이 나갔습니다." }
}
