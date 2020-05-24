//
//  NumberOfRooms.swift
//  ProgrammingProblems
//
//  Copyright © 2020 roseMelon. All rights reserved.
//
	
/*
 Graph / 방의 개수 (Number of rooms)
 Problem from https://programmers.co.kr/learn/courses/30/lessons/49190

 solution([6, 6, 6, 4, 4, 4, 2, 2, 2, 0, 0, 0, 1, 6, 5, 5, 3, 6, 0]) // 3
*/

import Foundation

func solution(_ arrows:[Int]) -> Int {

    var visitedPoints: Set<Point> = [Point(x: 0,y: 0)]
    var history: [Point: [Int]] = [:]

    var counter = 0
    var lastPoint = Point(x: 0, y: 0)

    arrows.forEach { arrow in
        let origin = lastPoint
        lastPoint = origin.move(to: arrow)

        let point: (Point, ArrowType) = (arrow >= 4)
            ? (origin.move(to: arrow), ArrowType(rawValue: arrow-4)!)
            : (origin, ArrowType(rawValue: arrow)!)

        
        if history[point.0]?.contains(point.1.rawValue) ?? false { return }

        if point.1 == .upright || point.1 == .downright {
            let crossCheck = (point.1 == .upright)
                ? history[point.0.move(to: 0)]?.contains(3) ?? false
                : history[point.0.move(to: 4)]?.contains(1) ?? false
            
            if crossCheck { counter += 1 }
        }

        if visitedPoints.contains(origin.move(to: arrow)) { counter += 1 }

        
        visitedPoints.insert(origin.move(to: arrow))
        
        if let current = history[point.0] {
            history.updateValue(current + [point.1.rawValue], forKey: point.0)
        }else {
            history[point.0] = [point.1.rawValue]
        }
    }

    return counter
}

struct Point: Hashable {
    let x: Int
    let y: Int
    
    static let move = [(0,-1), (1,-1), (1,0), (1,1), (0,1), (-1,1), (-1,0), (-1,-1)]

    func move(to arrow: Int) -> Point {
        return Point(x: x + Point.move[arrow].0, y: y + Point.move[arrow].1)
    }
}

enum ArrowType: Int, CaseIterable {
    case up = 0, upright = 1, right = 2, downright = 3
}
