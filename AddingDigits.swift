//
//  AddingDigits.swift
//  ProgrammingProblems
//
//  Copyright © 2020 roseMelon. All rights reserved.
//
	
/*
 Practice Problem / 자릿수 더하기 (Adding digits)
 Problem from https://programmers.co.kr/learn/courses/30/lessons/12931

 solution(250) // 7
*/

import Foundation

func solution(_ n: Int) -> Int {
    return String(n).reduce(0) { $0 + (Int(String($1)) ?? 0) }
}

