import Foundation
/*
n개의 섬 사이 다리를 연결 costs 최소 
cost -> 섬1, 섬2, 비용
99 * 50 

비용순 정렬 후, 연결되지 않은 섬 간의 연결, 모든 노드가 연결되면 종료


*/
func solution(_ n: Int, _ costs: [[Int]]) -> Int {
    let sortedCosts = costs.sorted { $0[2] < $1[2] }
    var connected: [Set<Int>] = (0...n-1).map { [$0] }
    var minCost = 0
    
    var parents: [Int] = (0...n-1).map { $0 }
    // var count = [Int](repeating: 0, count: n)
    func find(of node: Int) -> Int {
        let parent = parents[node]
        guard parent != node else { return node }
        
        let highest = find(of: parent) 
        parents[node] = highest
        // count[highest] += 1
        return highest 
    }
    
    for nodeCost in sortedCosts {
        guard connected[0].count < n else { break }
        let nodeA = nodeCost[0]
        let nodeB = nodeCost[1]
        let cost = nodeCost[2]
        
        let parentA = find(of: nodeA)
        let parentB = find(of: nodeB)
        if parentA != parentB {
            minCost += cost
            parents[parentA] = parentB
//             count[parentB] += count[parentA]
            
//             if count[parentB] == n { break }
        }
        
    }
    
    return minCost
}