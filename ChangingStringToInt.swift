//
//  ChangingStringToInt.swift
//  ProgrammingProblems
//
//  Copyright © 2020 roseMelon. All rights reserved.
//
	
/*
 Practice Problem / 문자열 정수로 바꾸기 (Changing string to int)
 Problem from https://programmers.co.kr/learn/courses/30/lessons/12931

 solution("-200") // -200
*/

import Foundation

func solution(_ s: String) -> Int {
    return Int(s) ?? 0
}
