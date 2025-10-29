import Foundation

func solution(_ box:[Int], _ n:Int) -> Int {
    var answer = 1
    
    for length in box {
        answer *= length / n 
    }
    
    return answer
}