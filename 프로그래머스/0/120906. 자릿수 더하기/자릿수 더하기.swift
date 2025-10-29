import Foundation

func solution(_ n: Int) -> Int {
    var sum = 0
    var num = n
    
    while num != 0 {
        sum += num % 10 
        num /= 10
    }
    
    return sum
}