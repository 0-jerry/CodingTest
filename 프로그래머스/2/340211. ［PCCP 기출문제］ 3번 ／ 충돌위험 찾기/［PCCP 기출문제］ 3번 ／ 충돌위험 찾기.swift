import Foundation

/*
2차원 좌표 (r, c)
n개의 포인트
운송경로는 포인트들의 배열 -> 첫 포인트에서 시작 마지막 포인트에서 종료
로봇들은 0초에 동시에 출발

이동 방법
1초마다 1씩 이동 가능. 
row를 먼저 이동하고, column을 이동최단 경로로만 이동.

충돌
동일 시간대에 충돌이 발생한 포인트들을 모두 카운팅 (하나의 포인트에서 3대 이상이 충돌하더라도 1 충돌로 생각)

마지막 포인트에 도착한 로봇은 이후 제거

points: [[2개의 요소를 갖는 Int 배열]]
routes: 로봇별 주어진 포인트 경로 
result: 충돌횟수 

struct Position {
    let x: Int
    let y: Int

    init(_ x: Int, _ y: Int)

    func nextPosition(to position: Position) -> Position {
    
    }
}

로봇 정의
루트를 stack 으로 저장
이동을 통해 포지션 수정, 도착 시 스택에서 제거
struct Robot {
    var position: Position
    var stack: [Position]
    var finished: Bool { stack.isEmpty }
    
    mutating func move() 
}


*/

func solution(_ points:[[Int]], _ routes:[[Int]]) -> Int {
    
    struct Position: Hashable, CustomStringConvertible {
        let r: Int
        let c: Int
        var description: String {
            "(r:\(r), c:\(c))"
        }
        init(_ r: Int, _ c: Int) {
            self.r = r
            self.c = c
        }

        func next(to target: Position) -> Position {
            var nextR = r
            var nextC = c
            
            if r != target.r {
                nextR += r < target.r ? 1 : -1
            } else {
                nextC += c < target.c ? 1 : -1
            }
            
            return Position(nextR, nextC)
        }
    }
    
   class Robot {
        var stack: [Position]
        var position: Position
        var isFinished: Bool { stack.isEmpty }
       
       init(_ route: [Position]) {
           var stack = route.reversed().map { $0 }
           self.position = stack.removeLast()
           self.stack = stack 
           
       }

        func move() {
            guard let target = stack.last else { return }
            let nextPosition = position.next(to: target)
            
            if nextPosition == target { stack.removeLast() }
            position = nextPosition
        }
    }
    
    let positions: [Position] = points.map { Position($0[0], $0[1]) }
    var robots: [Robot] = routes.map {
        let route = $0.map { positions[$0-1] }
        return Robot(route)
    }
    
    func count() -> Int {
        var current: [Position: Int] = [:]
        robots.forEach { current[$0.position, default: 0] += 1 }
        return current.filter { $0.value >= 2 }.count 
    }
    
    var answer = 0

    while !robots.isEmpty {
        answer += count()
        robots = robots.filter { !$0.isFinished }
        robots.forEach { $0.move() }
    }
    
    return answer
}