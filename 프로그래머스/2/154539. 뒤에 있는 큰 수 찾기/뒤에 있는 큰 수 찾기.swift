import Foundation
// 스택을 통해 더 큰 수를 발견하지 못한 값들을 저장하며 탐색 -> 이 경우 스택에 쌓이는 앞의 수가 가장 큰 수를 유지하게 됨
// 탐색하며 발견한 수를 스택의 마지막 수와 비교,
// 발견한 수가 스택의 마지막 수보다 크다면, 스택에서 해당 값을 꺼내 인덱스를 통한 접근으로 answer 의 값을 수정
// 스택의 다음 인자와의 비교를 이어나감, 그러다 스택의 마지막 인자가 현재의 값보다 클 경우 스택에 대한 탐색을 중단하고, 현재 값을 스택에 담는다.
// 다시 기존 배열 탐색을 이어나감 
func solution(_ numbers:[Int]) -> [Int] {
    var answer = [Int]()
    var stack = [(Int, Int)]()
    let numbers = numbers.enumerated()
    
    for number in numbers {
        answer.append(-1)
        while !stack.isEmpty {
            if stack.last!.1 >= number.1 { break }
            let last = stack.removeLast()
            answer[last.0] = number.1
        }
        stack.append(number)
    }
    
    return answer
}