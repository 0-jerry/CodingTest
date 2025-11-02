import Foundation
/*
1. sequence 중 일부의 시퀀스 sequence[a...b] -> [a, b]
2. sequence[a...b] 의 합은 k 이다
3. sequence[a...b].count 는 최소여야한다.
4. 해당 조건들을 만족하는 값 중 a와 b는 작아야한다.

뒤에서부터 탐색
성립하는 경우, 갯수가 같은 이전 시퀀스들을 탐색하며 최소 a 값을 찾는다

최소 시퀀스 길이 찾기 및 시작 시퀀스 찾기.
한 단계씩 앞으로 전진하기 - 가장 앞의 값과 가장 뒤의 값이 같은 경우 전진
*/
func solution(_ sequence: [Int], _ k: Int) -> [Int] {
    var result = [sequence.count-1, sequence.count-1]
    var sum = sequence[result[1]] 
    
    while sum != k {
        if sum < k {
            sum += sequence[result[0]-1]
            result[0] -= 1
        } else if sum > k {
            sum -= sequence[result[1]]
            result[1] -= 1
        }
    }
    
    func progressible() -> Bool {
        let nextStart = result[0] - 1 
        let end = result[1]
        guard nextStart >= 0 else { return false }
        
        return sequence[end] == sequence[nextStart]
    }
    
    if progressible() {
        let element = sequence[result[0]]
        guard let firstIndex = sequence.firstIndex(of: element) else {
            return result
        }
        let length = result[1] - result[0]
        result = [firstIndex, firstIndex+length]
    }
    
    return result
}