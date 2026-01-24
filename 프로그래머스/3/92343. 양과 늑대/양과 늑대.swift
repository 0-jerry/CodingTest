import Foundation

func solution(_ info: [Int], _ edges: [[Int]]) -> Int {  
    
    func rootNode(from edges: [[Int]]) -> Node {
        typealias Edge = (parentIndex: Int, child: Node)
        let root = Node(0)
        var queue = Queue<Edge>(edges.map { ($0[0], Node($0[1])) })
        
        while !queue.isEmpty {
            guard let edge = queue.dequeue() else { break }
            if !root.append(edge.parentIndex, edge.child) {
                queue.enqueue(edge)
            }
        }
        
        return root
    }
    
    let root = rootNode(from: edges)
    var maxSheepCount = 1
    let tempVisited: [Bool] = {
        var visited = [Bool](repeating: false, count: info.count)
        visited[0] = true 
        return visited
    }()
    
    let routes: [[Int]] = { 
        var routes = [[Int]]()
        for nodeIndex in 1..<info.count {
            guard info[nodeIndex] == 0, 
                  let route = root.route(nodeIndex) else { continue }
            routes.append(route.reversed())
        }
        return routes
    }()
    
    func dfs(_ sheepCount: Int, _ wolfCount: Int, _ visited: [Bool]) {
        guard sheepCount > wolfCount else { return }
        
        let filteredRoute = routes.filter { 
            guard let last = $0.last else { return false }
            return !visited[last]
        }
        
        maxSheepCount = max(maxSheepCount, sheepCount)
        
        for route in filteredRoute {
            var currentSheepCount = sheepCount
            var currentWolfCount = wolfCount
            var currentVisited = visited
            for nodeIndex in route {
                guard currentSheepCount > currentWolfCount else { break }
                guard !currentVisited[nodeIndex] else { continue }
                if info[nodeIndex] == 0 {
                    currentSheepCount += 1
                } else {
                    currentWolfCount += 1
                }
                currentVisited[nodeIndex] = true
            }
            dfs(currentSheepCount, currentWolfCount, currentVisited)
        }
    }
    dfs(1, 0, tempVisited)
    
    return maxSheepCount
}

struct Queue<T> {
    private var values: [T] = []
    private var index: Int = 0 
    var isEmpty: Bool { values.count <= index }
    
    init(_ values: [T]) {
        self.values = values
    }
    
    mutating func enqueue(_ value: T) {
        values.append(value)
    }
    
    mutating func dequeue() -> T? {
        guard !isEmpty else { return nil }
        let value = values[index]
        index += 1 
        return value 
    } 
}

class Node {
    let index: Int
    var leftNode: Node? = nil
    var rightNode: Node? = nil
    var count: Int {
        (leftNode?.count ?? 0) + (rightNode?.count ?? 0) + 1
    }
    
    init(_ index: Int) {
        self.index = index
    }
    
    func append(_ parentIndex: Int, _ child: Node) -> Bool {
        if parentIndex == index {
            if leftNode == nil {
                leftNode = child
            } else {
                rightNode = child 
            }
            return true
        } else if let leftNode = self.leftNode, 
                  leftNode.append(parentIndex, child) { 
            return true 
        } else if let rightNode = self.rightNode,
                  rightNode.append(parentIndex, child) {
            return true
        } else {
            return false 
        }
    }
    
    func route(_ nodeIndex: Int) -> [Int]? {
        guard nodeIndex != index else {
            return [index]
        } 
        
        for child in [leftNode, rightNode] {
            guard let child = child else { continue }
            if var route = child.route(nodeIndex) {
                route.append(index)
                return route
            }
        }
        
        return nil
    }
}
    