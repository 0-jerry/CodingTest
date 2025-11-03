import Foundation
/*
DFS(index: Int, a: Int, b: Int)
n/m 을 초과하는 경우 탐색 중단, 탐색이 끝난 경우 최솟값 비교 저장
포지션 저장 방식? (중복 탐색 금지 및 비효율 탐색도 중단)
    두 값 모두 이하인 값이 존재하는 경우 중단


*/

func solution(_ info:[[Int]], _ n:Int, _ m:Int) -> Int {
    let N = info.count
    let _n = n; let _m = m
    let totalB = info.reduce(into: 0) { o, v in o += v[1] }
    let isBStealAll = totalB < m

    if isBStealAll {
        return 0
    }

    var memo = [[[Int]]](
        repeating: [[Int]](
            repeating: [Int](
                repeating: -1,
                count: m
            ),
            count: n
        ),
        count: info.count
    )

    func solve(_ index: Int, _ curN: Int, _ curM: Int) -> Int {
        if index == N {
            return curN
        } 

        if memo[index][curN][curM] != -1 {
            return memo[index][curN][curM]
        }  

        var mins = Int.max
        let cur1 = info[index][1] + curM
        if cur1 < _m {
            mins = min(mins, solve(index + 1, curN, cur1))
        }
        let cur2 = info[index][0] + curN
        if cur2 < _n {
            mins = min(mins, solve(index + 1, cur2, curM))
        }
        memo[index][curN][curM] = mins
        return memo[index][curN][curM]
    }
    let value = solve(0, 0, 0)
    return value == Int.max ? -1 : value
}

