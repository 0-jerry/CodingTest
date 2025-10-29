import Foundation

func solution(_ n:Int) -> Int {
    let sqrtValue = Int(sqrt(Double(n)))
    var answer = 0 
    
    for num in 1...sqrtValue {
        if n % num == 0 {
            answer += 2
        }
    }
    if sqrtValue * sqrtValue == n {
        answer -= 1
    }
    return answer
}