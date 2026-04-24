import Foundation

func solution(_ n: Int, _ costs: [[Int]]) -> Int {
    
    var parents: [Int] = (0...n-1).map { $0 }
    
    func find(of node: Int) -> Int {
        let parent = parents[node]
        guard parent != node else { 
            return node 
        }
        
        let highest = find(of: parent) 
        parents[node] = highest
        return highest 
    }
    
    let sortedCosts = costs.sorted { $0[2] < $1[2] }
    var minCost = 0
    var count = [Int](repeating: 1, count: n)
    
    for cost in sortedCosts {
        let parentA = find(of: cost[0])
        let parentB = find(of: cost[1])
        
        if parentA != parentB {
            minCost += cost[2]
            parents[parentA] = parentB
            count[parentB] += count[parentA]
            
            if count[parentB] == n { break }
        }
        
    }
    
    return minCost
}