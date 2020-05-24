//
//  MoveBlock.swift
//  ProgrammingProblems
//
//  Copyright © 2020 roseMelon. All rights reserved.
//

/*
 2020 KAKAO BLIND RECRUITMENT / 블럭 이동하기 (Move block)
 Problem from https://programmers.co.kr/learn/courses/30/lessons/60063

 solution([[0, 0, 0, 1, 1], [0, 0, 0, 1, 0], [0, 1, 0, 1, 1], [1, 1, 0, 0, 1], [0, 0, 0, 0, 0]]) // 7
*/

import Foundation

struct State: Hashable {
    let point: Point
    let way: Way
    
    var subPoint: (Int, Int) {
        return way == .right ? (point.x, point.y + 1) : (point.x + 1, point.y)
    }
    
    func movableState() -> [State] {
        let move = [(point.x - 1, point.y), (point.x + 1, point.y), (point.x, point.y - 1), (point.x, point.y + 1)]
            .map { State(point: Point($0), way: way) }
            .filter { checkPointAvailable($0.point.toTuple()) && checkPointAvailable($0.subPoint) }
            .filter { !checkRecordExist($0) }
        
        let rotate = [(false, -1, -1), (false, 1, -1), (true, 1, 1), (true, -1, 1)]
            .map { elem -> State? in
                let checkPoint = elem.0 ? point.toTuple() : subPoint
                let add = way == .right ? (elem.1, elem.2) : (elem.2, elem.1)
                let next = elem.0 ? ((point.x + add.0, point.y + add.1), subPoint) : (point.toTuple(), (subPoint.0 + add.0, subPoint.1 + add.1))
                let sortedPoint = (next.0.0 - next.1.0 > 0 || next.0.1 - next.1.1 > 0) ? (next.1, next.0) : next
                let newRecord = State(point: Point(sortedPoint.0), way: way == .right ? .down : .right)
                guard checkPointAvailable(elem.0 ? next.0 : next.1) else { return nil }
                guard MAP[checkPoint.0 + (way == .right ? add.0 : 0)][checkPoint.1 + (way == .right ? 0 : add.1)] != 1 else { return nil }
                guard !checkRecordExist(newRecord) else { return nil }
                return newRecord
            }.filter { $0 != nil }.map { $0! }
        
        return move + rotate
    }
    
    enum Way {
        case right, down
    }
}

struct Point: Hashable {
    let x: Int
    let y: Int
    
    init(_ point: (Int, Int)) {
        self.x = point.0
        self.y = point.1
    }
    
    func toTuple() -> (Int, Int) { return (x,y) }
}

var MAP: [[Int]] = []
var record: [Set<State>] = []

func solution(_ board:[[Int]]) -> Int {
    MAP = board
    record.append([State(point: Point((0,0)), way: .right)])
    return run(counter: 1)
}

func run(counter: Int) -> Int {
    guard let last = record.last else { return 0 }
    
    if last.contains(State(point: Point((MAP.count - 1, MAP.count - 2)), way: .right))
        || last.contains(State(point: Point((MAP.count - 2, MAP.count - 1)), way: .down)) {
        return counter - 1
    }
    
    var tmp: Set<State> = []
    for elem in last {
        elem.movableState().forEach { tmp.insert($0) }
    }
    record.append(tmp)

    return run(counter: counter + 1)
}

func checkPointAvailable(_ p: (Int,Int)) -> Bool {
    return p.0 < MAP.count && p.0 >= 0 && p.1 < MAP.count && p.1 >= 0 && MAP[p.0][p.1] != 1
}

func checkRecordExist(_ state: State) -> Bool {
    return record.reduce(false) { $0 || $1.contains(state) }
}
