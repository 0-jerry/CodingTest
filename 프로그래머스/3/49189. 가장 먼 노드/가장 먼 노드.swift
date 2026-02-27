import Foundation

func solution(_ n: Int, _ edge: [[Int]]) -> Int {

    var connected = [[Int]](repeating: [], count: n + 1)
    var length = [Int](repeating: -1, count: n + 1)
    
    for connect in edge {
        let (lhs, rhs) = (connect[0], connect[1])
        connected[lhs].append(rhs)
        connected[rhs].append(lhs)
    }
    
    var maxLength = 0
    var count = 0
        
    let queue = Queue<Int>()
    length[1] = 0
    queue.enqueue(1)
    
    while !queue.isEmpty {
        guard let node = queue.dequeue() else { break }
        
        let currentLength = length[node]
        
        if currentLength == maxLength {
            count += 1
        } else {
            count = 1 
            maxLength = currentLength
        }
        
        let nextLength = currentLength + 1
        
        for nextNodeIndex in connected[node] {
            guard length[nextNodeIndex] == -1 else { continue }
            
            length[nextNodeIndex] = nextLength
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