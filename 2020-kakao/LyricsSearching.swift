//
//  LyricsSearching.swift
//  ProgrammingProblems
//
//  Copyright © 2020 roseMelon. All rights reserved.
//

/*
 2020 KAKAO BLIND RECRUITMENT / 가사 검색 (Lyrics searching)
 Problem from https://programmers.co.kr/learn/courses/30/lessons/42895

 solution(["frodo", "front", "frost", "frozen", "frame", "kakao"], ["fro??", "????o", "fr???", "fro???", "pro?"]) // [3, 2, 4, 1, 0]
*/

import Foundation

func solution(_ words: [String], _ queries: [String]) -> [Int] {

    var states: [Int: (State, State)] = [:]

    var dic: [String: Int] = [:]

    words.forEach { word in
        let array = Array(word).map { String($0) }
        let reversed = array.reversed()
        
        var state = states[word.count]?.0 ?? State()
        var reverseState = states[word.count]?.1 ?? State()

        states[word.count] = (state, reverseState)
        
        array.forEach { state = state.countAndNext($0) }
        reversed.forEach { reverseState = reverseState.countAndNext($0) }
    }

    Set(queries).forEach {
        guard let state = states[$0.count] else { return }
        
        var queryArray = Array($0).map { String($0) }
        var findState: State = (queryArray[0] != "?") ? state.0 : state.1
        
        if (queryArray[0] == "?") { queryArray.reverse() }
        
        for i in queryArray {
            if (i == "?") { dic[$0] = findState.count; break }

            guard let state = findState.list[i] else { break }
            
            findState = state
        }
    }

    return queries.map { dic[$0] ?? 0 }
}

class State {
    var count: Int = 0
    var list: [String: State] = [:]

    func countAndNext(_ str: String) -> State {
        count += 1
        
        if let state = list[str] {
            return state
        }else {
            let new = State()
            list[str] = new
            return new
        }
    }
}
