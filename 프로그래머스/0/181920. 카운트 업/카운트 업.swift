import Foundation

func solution(_ start_num: Int, _ end_num: Int) -> [Int] {
    var answer = [Int]()
    
    for num in start_num...end_num {
        answer.append(num)
    }
    
    return answer
}