import Foundation

func solution(_ cost: [[Int]], _ hint: [[Int]]) -> Int {
    let length = cost.count 
    let tempHintCount = [Int](repeating: 0, count: length)
    let hintCost = hint.compactMap { $0.first }
    let hintBundle = hint.map { $0.dropFirst().map { $0 - 1 } }
    
    func isEnable(_ targetCost: Int) -> Bool {
        func dfs(_ currentStage: Int, _ currentCost: Int, _ hintCount: [Int]) -> Bool {
            var nextCost = currentCost + cost[currentStage][min(length-1, hintCount[currentStage])]
            let nextStage = currentStage + 1

            guard nextCost <= targetCost else { 
                return false 
            }
            
            if nextStage == length { 
                return true 
            } else if dfs(nextStage, nextCost, hintCount) { 
                return true 
            } else {
                var nextHintCount = hintCount 
                hintBundle[currentStage].forEach { nextHintCount[$0] += 1 }
                nextCost += hintCost[currentStage]
                
                return dfs(nextStage, nextCost, nextHintCount)
            }
        }
        return dfs(0, 0, tempHintCount)
    }
    
    let minCost = (1...length-1).reduce(cost[0][0]) { $0 + cost[$1][length-1] }
    let maxCost = 16 * 100_000 

    return lowerBound(first: minCost, last: maxCost, closure: isEnable)
}

func lowerBound(first: Int, last: Int, closure: (Int) -> Bool) -> Int {
    var left = first
    var right = last
    var answer = right
    
    while left <= right {
        let mid = (right - left) / 2 + left
        if closure(mid) {
            right = mid - 1 
            answer = mid
        } else {
            left = mid + 1 
        }
    }
    
    return answer
}
