import Foundation

func solution(_ n: Int, _ q: [[Int]], _ ans: [Int]) -> Int {
    guard !ans.contains(5) else { return 1 }

    
    let q = q.map { Set($0) }
    func variation(in items: Set<Int>, for count: Int) -> [Set<Int>] {
        let sorted = Array(items)
        var answer = [Set<Int>]()
        
        func dfs(_ remain: [Int], _ current: Set<Int>, _ count: Int) {
            guard count > current.count else {
                answer.append(current)
                return 
            }
            var remain = remain
            let minimumCount = count - current.count 
            while remain.count >= minimumCount {
                let last = remain.removeLast()
                var items = current
                items.insert(last)
                dfs(remain, items, count)
            }
        }
        dfs(sorted, [], count)
        
        return answer
    }
    
    var neverUsed = [Int]() 
    
    (0..<q.count).forEach { 
        if ans[$0] == 0 { neverUsed + q[$0] } 
    }
    
    let numbers = Set(1...n).subtracting(Set(neverUsed))
    
    let allCase = variation(in: numbers, for: 5).filter {
        for i in 0..<q.count {
            guard q[i].intersection(($0)).count == ans[i] else { return false }
        }
        return true
    }
    
    return allCase.count
}