import Foundation
/*
n개의 노드 그래프

1번에서 가장 멀리 떨어진 노드의 갯수를 구하기
BFS - 
*/
func solution(_ n: Int, _ vertex: [[Int]]) -> Int {
    var maximum = 0 
    var connected = [[Int]](repeating: [], count: n + 1)
    var visited = [Bool](repeating: false, count: n + 1)
    var distanceNodes = [Int: Int]()
    for route in vertex {
        let nodeA = route[0]
        let nodeB = route[1]
        connected[nodeA].append(nodeB)
        connected[nodeB].append(nodeA)
    }
    
    var queue = Queue()
    queue.enqueue((node: 1, distance: 0))
    visited[1] = true 
    
    while !queue.isEmpty {
        guard let first = queue.dequeue() else { break }
        
        let currentDistance = first.distance 
        let nextDistance = currentDistance + 1
        maximum = currentDistance
        distanceNodes[currentDistance, default: 0] += 1
        let subNodes = connected[first.node].filter { !visited[$0] }
        
        for subNode in subNodes {
            visited[subNode] = true
            queue.enqueue((subNode, nextDistance))
            
        }
    }
    
    return distanceNodes[maximum] ?? -1
}

class Queue {
    typealias Pair = (node: Int, distance: Int)
    
    private var index = 0
    private var values = [Pair]()
    
    var isEmpty: Bool { values.count <= index }
    
    func enqueue(_ value: Pair) {
        values.append(value)
    }
    
    func dequeue() -> Pair? {
        guard !isEmpty else { return nil }
        
        let value = values[index]
        index += 1 
        
        return value
    }
}
