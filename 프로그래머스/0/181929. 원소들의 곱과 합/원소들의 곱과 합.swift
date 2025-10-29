import Foundation

func solution(_ num_list:[Int]) -> Int {
    var mul = 1
    var sum = 0
    
    for num in num_list {
        mul *= num
        sum += num
    }
    
    return mul < sum * sum ? 1 : 0
}