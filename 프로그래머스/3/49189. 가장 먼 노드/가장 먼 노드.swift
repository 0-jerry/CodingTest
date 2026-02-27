import Foundation

func solution(_ n: Int, _ edge: [[Int]]) -> Int {

    var connected = [[Int]](repeating: [], count: n + 1)
    var distance = [Int](repeating: -1, count: n + 1)
    
    for connect in edge {
        let (lhs, rhs) = (connect[0], connect[1])
        connected[lhs].append(rhs)
        connected[rhs].append(lhs)
    }
    
    var maxDistance = 0
    var count = 0
        
    let queue = Queue<Int>()
    distance[1] = 0
    queue.enqueue(1)
    
    while !queue.isEmpty {
        guard let node = queue.dequeue() else { break }
        
        let currentDistance = distance[node]
        
        if currentDistance != maxDistance {
            count = 0
            maxDistance = currentDistance
        }
        count += 1
        
        let nextDistance = currentDistance + 1
        
        for nextNodeIndex in connected[node] {
            guard distance[nextNodeIndex] == -1 else { continue }
            
            distance[nextNodeIndex] = nextDistance
            queue.enqueue(nextNodeIndex)
        }
    }
    
    return count
}

class Queue<T> {
    var elements: [T] = []
    private var index = 0 
    var isEmpty: Bool { elements.count <= index }
    
    func enqueue(_ element: T) {
        elements.append(element)
    }
    
    func dequeue() -> T? {
        guard !isEmpty else { return nil }
        let element = elements[index]
        index += 1
        return element
    }
}