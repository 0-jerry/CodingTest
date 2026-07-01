import Foundation

func solution(_ edges:[[Int]], _ target:[Int]) -> [Int] {
    //    
    var answer = [Int]()
    //
    var totalHitCount = 0
    var hitCount = [Int](repeating: 0, count: target.count)
    var currentNodeIndex = [Int](repeating: 0, count: target.count)
    //
    var hittedNode = [Int]()
    var matchedCount: Int = target.filter { $0 == 0 }.count   
    let matchMax: [Int] = target
    let matchMin: [Int] = target.map { ($0 % 3 == 0) ? ($0 / 3) : ($0 / 3 + 1) }
    
    let graph: [[Int]] = {
        var graph = [[Int]](repeating: [Int](), count: edges.count + 1)
        edges.forEach { graph[$0[0]-1].append($0[1]-1) }
        return graph.map { $0.sorted() }
    }()
    
    func find() -> Int {
        var node = 0
        while !graph[node].isEmpty {
            let index = currentNodeIndex[node]
            currentNodeIndex[node] = (index + 1) % graph[node].count
            node = graph[node][index]
        }

        return node
    }
    
    while matchedCount < target.count {
        let node = find()
        hittedNode.append(node)
        hitCount[node] += 1
        totalHitCount += 1
        if hitCount[node] == matchMin[node] {
            matchedCount += 1
        } else if hitCount[node] > matchMax[node] {
            return [-1]
        } else { continue }
    }
    
    func makeReversed(_ hitCount: Int, _ targetValue: Int) -> [Int] {
        var arr = [Int](repeating: 1, count: hitCount)
        var remain = targetValue - hitCount 
        for i in 0..<hitCount {
            guard remain > 1 else { 
                arr[i] += remain
                remain = 0
                break
            }
            arr[i] = 3
            remain -= 2
        }
        
        return arr
    }
    
    var nodeValues: [[Int]] = hitCount.enumerated()
    .map { index, element in 
        makeReversed(element, target[index])
    }
    
    for node in hittedNode {
        let value = nodeValues[node].removeLast()
        answer.append(value)
    }
    
    return answer
}