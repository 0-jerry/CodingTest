import Foundation

func solution(_ num_list:[Int], _ n:Int) -> [Int] {
    var answer = [Int]()
    
    for num in num_list {
        guard answer.count < n else { break }
        answer.append(num)
    }
    
    return answer
}