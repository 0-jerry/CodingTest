import Foundation

func solution(_ n: Int) -> Int {
    var sum = 0 
    
    for num in 0...n/2 {
        if n % 2 == 1 {
            sum += num * 2 + 1
        } else {
            sum += (2 * num) * (2 * num)
        }
    }
    
    return sum
}