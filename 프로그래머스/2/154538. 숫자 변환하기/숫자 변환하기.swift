import Foundation

func solution(
    _ x: Int, 
    _ y: Int, 
    _ n: Int
) -> Int {
    var memo = [Int](repeating: Int.max, count: 1_000_001)
    memo[x] = 0
    for number in x...y {
        let count = memo[number]
        guard count != Int.max else { continue }
        [
            number * 2,
            number * 3,
            number + n
        ].forEach {
            guard $0 <= y else { return }
            memo[$0] = min(memo[$0], count + 1)
        }
    }
    return memo[y] != Int.max ? memo[y] : -1
}