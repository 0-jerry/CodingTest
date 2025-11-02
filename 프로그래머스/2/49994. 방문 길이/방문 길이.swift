import Foundation
/*
상하좌우 포지션 이동을 저장하고, 중복된 값을 제거 (중복조건 = 같은 길을 지나가는 경우, 방향이 상관있는지는 명시되어있지 않지만 길이라는 특성상 방향과 무관하다고 인지)
이동방식
U,D,R,L 문자열을 통해 -5~5 범위내에서만 이동 초과하는 경우, 이동하지 않음

이동경로를 Route: Equtable(Hashable) 을 준수하도록 정의, Set 을 통해 취합

*/
func solution(_ dirs: String) -> Int {
    
    struct Position: Hashable {
        let x: Int
        let y: Int
        
        init(_ x: Int, _ y: Int) {
            self.x = x
            self.y = y
        }
        
        static func == (_ lhs: Self, _ rhs: Self) -> Bool {
            lhs.x == rhs.x && lhs.y == rhs.y
        }
    }
    
    var current = Position(0, 0)
    
    struct Route: Hashable {
        let position1: Position
        let position2: Position
        
        private static let range = Set(-5...5)
        
        // static func == (_ lhs: Self, _ rhs: Self) -> Bool {
        //     Set([lhs.position1, lhs.position2]) == Set([rhs.position1, rhs.position2])
        // }
        
        init(_ position1: Position, _ position2: Position) {
            self.position1 = position1
            self.position2 = position2
        }
        
        init?(_ current: Position, _ xDir: Int, _ yDir: Int) {
            let nextX = current.x + xDir
            let nextY = current.y + yDir
            
            guard Self.range.contains(nextX),
                  Self.range.contains(nextY) else { return nil }
            
            let next = Position(nextX, nextY)
            
            self.position1 = current
            self.position2 = next
        }
        
        func reversed() -> Route {
            Route(position2, position1)
        }
    }
    
    var routes = Set<Route>()
    
    for char in dirs {
        var dir: (Int, Int) = (0, 0)
        
        switch char {
            case "U": dir = (0, 1)
            case "D": dir = (0, -1)
            case "L": dir = (-1, 0)
            case "R": dir = (1, 0)
            default: continue
        }
        
        guard let route = Route(current, dir.0, dir.1) else { continue }
        if !(routes.contains(route) || routes.contains(route.reversed())) {
            routes.insert(route)
        }
        current = route.position2
    }
    
    return routes.count
}