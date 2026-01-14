import Foundation

func solution(_ maps: [String]) -> Int {    
    let width = maps[0].count
    let height = maps.count
    let area = width * height 
    
    struct Position: Hashable {
        
        typealias Direction = (x: Int, y: Int)
        static let directions: [Direction] = [(0, 1), (0, -1), (-1, 0), (1, 0)]
        
        let x: Int
        let y: Int
        
        init(_ x: Int, _ y: Int) {
            self.x = x
            self.y = y
        }
        
        func move(to direction: Direction) -> Position {
            Position(x + direction.x, y + direction.y)
        }
        
    }
    
    var road = Set<Position>()
    var specialBoard = [Character: Position]()
    
    for y in 0..<maps.count {
        let line = maps[y]
        for (x, char) in line.enumerated() {
            guard char != "X" else { continue }
            let currentPosition = Position(x,y)
            road.insert(currentPosition)
            if char != "O" { specialBoard[char] = currentPosition }
        }
    }
    
    guard let start = specialBoard["S"], 
          let lever = specialBoard["L"], 
          let exit = specialBoard["E"] else { return -1 }
    
    func length(from startPosition: Position, to endPosition: Position) -> Int? {
        var index = 0 
        var queue: [(position: Position, length: Int)] = [(startPosition, 0)]
        var visited = [Bool](repeating: false, count: area)
        
        while index < queue.count {
            let current = queue[index]
            let currentPosition = current.position
            let currentLength = current.length
            let nextLength = currentLength + 1

            if currentPosition == endPosition { return currentLength }
            
            for direction in Position.directions {
                let nextPosition = currentPosition.move(to: direction)
                let flatIndex = nextPosition.x + nextPosition.y * width
                
                guard road.contains(nextPosition) else { continue }
                guard !visited[flatIndex] else { continue }
                
                queue.append((nextPosition, nextLength))
                visited[flatIndex] = true
            }
            
            index += 1
        }
        
        return nil 
    }
    
    guard let firstRouteLength = length(from: start, to: lever),
          let secondRouteLength = length(from: lever, to: exit) else { return -1 }
    
    return firstRouteLength + secondRouteLength
}