import Foundation

func solution(_ storage: [String], _ requests: [String]) -> Int {
    
    struct Position: Hashable {
        let x: Int
        let y: Int 
        
        init(_ x: Int, _ y: Int) {
            self.x = x
            self.y = y
        }
        
        static var xLength = 0 
        static var yLength = 0
        
        func closed() -> Set<Position> {
            var closedPositions = Set<Position>()
            
            [(0, 1), (0, -1), (1, 0), (-1, 0)].forEach {
                let nextX = x + $0.0
                let nextY = y + $0.1
                guard nextX >= 0 && nextX < Position.xLength,
                      nextY >= 0 && nextY < Position.yLength else { return }
                let position = Position(x + $0.0, y + $0.1)
                closedPositions.insert(position)
            }
            
            return closedPositions
        }
    }
    
    Position.xLength = storage[0].count
    Position.yLength = storage.count
    
    var mapped: [[Character]] = Array(repeating: Array<Character>(repeating: "_", count: Position.xLength), count: Position.yLength)
    var position: [Character: Set<Position>] = [:]
    
    for row in storage.enumerated() {
        for column in row.1.enumerated() {
            let current = Position(column.0, row.0)
            mapped[row.0][column.0] = column.1
            position[column.1, default: []].insert(current)
        }
    }
    
    var outside = Set<Position>()
    var removed = Set<Position>()
    
    for y in 0..<Position.yLength {
        let `left` = Position(0, y)
        let `right` = Position(Position.xLength-1, y)
        outside.insert(`left`)
        outside.insert(`right`)
    }
    
    for x in 0..<Position.xLength {
        let top = Position(x, 0)
        let bottom = Position(x, Position.yLength-1)
        outside.insert(top)
        outside.insert(bottom)
    }
    
    func remove(_ positions: Set<Position>) {
        positions.forEach { position in 
            mapped[position.y][position.x] = "_"
            removed.insert(position)
        }
        updateOutside(by: positions)
    }

    func updateOutside(by positions: Set<Position>) {
        var queue = Array(positions).filter { outside.contains($0) }
        var used = Set<Position>()
        
        while !queue.isEmpty {
            let closed = queue.removeFirst().closed()
            closed.forEach {
                if removed.contains($0) {
                    if !used.contains($0) {
                        used.insert($0)
                        queue.append($0)
                    }
                } else {
                    outside.insert($0)
                    used.insert($0)
                }
            }
        }
    }
    
    func oldRemove(_ char: Character) {
        guard let positions = position[char] else { return }
        let filtered = positions.filter { outside.contains($0) && !removed.contains($0) }
        remove(filtered)
    }
    
    func newRemove(_ char: Character) {
        guard let positions = position[char] else { return }
        let filtered = positions.filter { !removed.contains($0) }
        remove(filtered)
    }
    
    requests.forEach {
        if $0.count == 1 {
            oldRemove($0.first!)
        } else {
            newRemove($0.first!)
        }
    }
    
    return Position.xLength * Position.yLength - removed.count
}