import Foundation
/*
n개의 풍선, 서로 다른 숫자

인접한 두 풍선 선택, 둘 중 하나 터뜨리기 (번호가 더 작은 풍선을 터트리는 행위는 최대 1번)

양 끝의 경우 항상 가능
양쪽을 비교했을 때, 양 방향 모두에 자신보다 작은 풍선이 존재하는 경우 불가능 
-16,-92,-71,-68,-61,-33

왼쪽, 오른쪽에서 이동하며, 가장 작은 수를 저장
만약 새로 발견한 숫자가 그 숫자보다 작은 경우 업데이트 및 true 저장

*/
func solution(_ a: [Int]) -> Int {
    
    func minCal(isLeft: Bool) -> [Bool] {
        var min = (isLeft ? a[0] : a[a.count-1]) + 1
        var minCheck = [Bool](repeating: false, count: a.count)
        
        for i in 0..<a.count {
            let index = isLeft ? i : (a.count - i - 1) 
            let current = a[index]
            if current < min {
                min = current
                minCheck[index] = true
            } 
        }
        
        return minCheck
    }
    
    let left = minCal(isLeft: true)
    let right = minCal(isLeft: false)
    
    var answer = 0 
    
    for i in 0..<a.count {
        if left[i] || right[i] {
            answer += 1
        }
    }
    
    return answer
}