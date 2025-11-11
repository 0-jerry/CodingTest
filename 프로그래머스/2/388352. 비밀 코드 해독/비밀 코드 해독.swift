import Foundation

/*
1. ans 가 5를 포함한다면 -> 1
2. ans 가 0인 수들은 제외

1,2,3,4,5 -> 2개 -> 2개 이상 추가되어서는 안됨 
6,7,8,9,10 -> 3개 -> 3개 이상 추가되어서는 안됨

3,7,8,9,10 -> 4 -->> 6: X 3: O : 값이 교체되고, 하나의 추가 답이 나옴 

세 가지 부분으로 구별해서 볼 수 있다.
1. 겹치는 부분 (ans - count) -> 3번에서 사용
2. 겹치지않는 부분 (q - 현재)
3. 추가될 부분 2와 1을 통해 추가될 부분을 생성 
1+2 <= 5

*/

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
    
    let allCase = variation(in: Set(1...n), for: 5).filter {
        for i in 0..<q.count {
            guard q[i].intersection(($0)).count == ans[i] else { return false }
        }
        return true
    }
    
    return allCase.count
}