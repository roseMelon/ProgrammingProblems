//
//  CandidateKey.swift
//  ProgrammingProblems
//
//  Copyright © 2020 roseMelon. All rights reserved.
//
	
/*
 2019 KAKAO BLIND RECRUITMENT / 후보키 (Candidate key)
 Problem from https://programmers.co.kr/learn/courses/30/lessons/42890

 solution([["100","ryan","music","2"],["200","apeach","math","2"],["300","tube","computer","3"],["400","con","computer","4"],["500","muzi","music","3"],["600","apeach","music","2"]]) // 2
*/

import Foundation

func solution(_ relation: [[String]]) -> Int {
        
    var availableColumnAsKey: [Set<Int>] = []
    let columnLength = relation[0].count
    
    var combinationColumns: [[Set<Int>: [String]]] = [[:]]
    
    for j in 0..<relation[0].count {
        var column: [String] = []
        for i in 0..<relation.count {
            column.append(relation[i][j])
        }
        if Set(column).count == column.count { availableColumnAsKey.append([j]) }
        else { combinationColumns[0][[j]] = column }
    }
        
    if columnLength == 1 { return availableColumnAsKey.count}
            
    for count in 1..<columnLength {
        let columns = combinationColumns[count-1]
        
        var newColumn: [Set<Int>: [String]] = [:]
        
        columns.forEach { (columnIndices, data) in
            guard let max = columnIndices.max(), max+1 < columnLength else { return }
            
            for i in max+1..<columnLength {
                let newKey = Set(columnIndices + [i])
                                
                if availableColumnAsKey.reduce(false, { $0 || $1.isSubset(of: newKey) }) { continue }
                guard let item = combinationColumns[0][[i]] else { continue }
                
                let value = data.enumerated().map { $0.element + item[$0.offset] }
                if Set(value).count == value.count { availableColumnAsKey.append(newKey) }
                else { newColumn[newKey] = value }
            }
        }
        
        combinationColumns.append(newColumn)
    }
        
    return availableColumnAsKey.count
}
