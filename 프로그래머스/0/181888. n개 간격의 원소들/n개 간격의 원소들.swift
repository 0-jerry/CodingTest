import Foundation

func solution(_ num_list:[Int], _ n:Int) -> [Int] {
    var answer = [Int]()

    for num in num_list.enumerated() {
        if num.offset % n == 0 {
            answer.append(num.element)
        }
    }
    
    return answer
}