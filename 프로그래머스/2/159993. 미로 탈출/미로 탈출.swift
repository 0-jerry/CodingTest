import Foundation

func solution(_ maps: [String]) -> Int {    
    struct Position: Hashable {
        let x: Int
        let y: Int
    }
    
    var road = Set<Position>()
    var specialRoad = [Character: Position]()
    
    for y in 0..<maps.count {
        let line = maps[y]
        var x = -1 
        for char in line {
            x += 1
            guard char != "X" else { continue }
            let currentPosition = Position(x: x, y: y)
            road.insert(currentPosition)
            if char != "O" {
                specialRoad[char] = currentPosition
            }
        }
    }
    
    guard let start = specialRoad["S"], 
          let lever = specialRoad["L"], 
          let exit = specialRoad["E"] else { return -1 }
    
    func length(from startPosition: Position, to endPosition: Position) -> Int? {
        var index = 0 
        var queue: [(position: Position, length: Int)] = [(startPosition, 0)]
        var visited = Set<Position>()
        
        while index < queue.count {
            let current = queue[index]
            let currentPosition = current.position
            let currentLength = current.length
            
            if currentPosition == endPosition { 
                return currentLength 
            }
            
            let nextPositions = [
                (0, 1), 
                (0, -1), 
                (-1, 0), 
                (1, 0)
            ].map { Position(x: currentPosition.x + $0.0, y: currentPosition.y + $0.1) }
            .filter { road.contains($0) && !visited.contains($0) }

            let nextLength = currentLength + 1
            
            nextPositions.forEach { nextPosition in 
                queue.append((nextPosition, nextLength))
                visited.insert(nextPosition)
            }
            index += 1
        }
        
        return nil 
    }
    
    guard let first = length(from: start, to: lever),
          let second = length(from: lever, to: exit) else { return -1 }
    
    return first + second
}