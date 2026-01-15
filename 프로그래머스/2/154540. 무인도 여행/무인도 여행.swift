import Foundation

func solution(_ maps: [String]) -> [Int] {
    
    struct Node: Hashable {
        let x: Int
        let y: Int
        
        init(_ x: Int, _ y: Int) {
            self.x = x
            self.y = y
        }

    }
    
    let width = maps[0].count
    let height = maps.count
    
    var valueMatrix = [[Int]](repeating: [Int](repeating: 0, 
                                               count: width), 
                              count: height)
    
    var usableNodeSet = Set<Node>()
    var islands: [Int] = []
    
    for y in 0..<maps.count {
        for (x, char) in maps[y].enumerated() {
            guard let value = Int(String(char)) else { continue }
            valueMatrix[y][x] = value
            let node = Node(x, y)
            usableNodeSet.insert(node)
        }
    }
    
    guard !usableNodeSet.isEmpty else { return [-1] }
    
    func around(_ targetNode: Node) -> [Node] {        
        let directions: [(x: Int, y: Int)] = [(0, 1), (0, -1), (-1, 0), (1, 0)]
        var aroundNodes = [Node]()

        for direction in directions {
            let aroundNode = Node(
                targetNode.x + direction.x, 
                targetNode.y + direction.y
            )
            guard usableNodeSet.contains(aroundNode) else { continue }
            aroundNodes.append(aroundNode)
        }
        
        return aroundNodes
    }
    
    func sumConnectedNodes(with startNode: Node) -> Int {
        var queue = LinearQueue<Node>([startNode])   
        usableNodeSet.remove(startNode)

        var sum = 0
        
        while !queue.isEmpty {
            guard let currentNode = queue.dequeue() else { break }
            sum += valueMatrix[currentNode.y][currentNode.x]
            
            let aroundNodes = around(currentNode)
            for aroundNode in aroundNodes {
                queue.enqueue(aroundNode)
                usableNodeSet.remove(aroundNode)
            }
        }
        
        return sum
    }
    
    while !usableNodeSet.isEmpty {
        let startNode = usableNodeSet.removeFirst()
        let sum = sumConnectedNodes(with: startNode)
        islands.append(sum)
    }
    
    return islands.sorted()
}

struct LinearQueue<T> {
    private var index = 0
    private var values: [T]
    var isEmpty: Bool { index >= values.count }
    init(_ values: [T]) {
        self.values = values 
    }
    
    mutating func enqueue(_ value: T) {
        values.append(value)
    }
    
    mutating func dequeue() -> T? {
        guard index < values.count else { return nil }
        
        let value = values[index]
        index += 1
        
        return value
    }
    
}