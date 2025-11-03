import Foundation

func solution(_ info: [[Int]], _ n: Int, _ m: Int) -> Int {
    var result = Int.max
    
    // 💡 O(1) 조회를 위한 Set 사용
    // Set<String>을 사용해 (index, a, b) 조합을 저장
    // ⏱️ 조회/삽입: O(1) (평균)
    var visited = Set<String>()
    
    // 💡 Pareto frontier 개념 활용
    // 각 index에서 dominated되지 않는 (a, b) 상태만 저장
    // ⏱️ O(P) - P는 Pareto 최적 상태 수 (일반적으로 매우 작음)
    var paretoFrontier = [[[Int]]](repeating: [], count: info.count)
    
    // ⏱️ 최악: O(2^k) 하지만 실제로는 훨씬 적음
    func dfs(_ index: Int, _ a: Int, _ b: Int) {
        // ⏱️ O(1) - 가지치기
        guard a < n, b < m, result > a else { return }
        
        // ⏱️ O(1) - 종료 조건
        if index == info.count {
            result = a
            return
        }
        
        // ⏱️ O(1) - 중복 방문 체크 (Set 사용)
        let key = "\(index),\(a),\(b)"
        guard !visited.contains(key) else { return }
        visited.insert(key)
        
        // ⏱️ O(P) - Pareto dominated 체크 (P는 매우 작음, 보통 < 100)
        // 현재 상태가 다른 상태에 의해 dominated되는지 확인
        for state in paretoFrontier[index] {
            if state[0] <= a && state[1] <= b {
                return  // 더 좋은 상태가 이미 존재
            }
        }
        
        // Pareto frontier 업데이트
        // 현재 상태에 의해 dominated되는 상태들 제거
        paretoFrontier[index].removeAll { state in
            a <= state[0] && b <= state[1]
        }
        paretoFrontier[index].append([a, b])
        
        // ⏱️ O(1) - 물건 정보
        let item = info[index]
        let nextIndex = index + 1
        
        // 재귀 호출
        dfs(nextIndex, a + item[0], b)  // A가 가져가는 경우
        dfs(nextIndex, a, b + item[1])  // B가 가져가는 경우
    }
    
    dfs(0, 0, 0)
    return result == Int.max ? -1 : result
}