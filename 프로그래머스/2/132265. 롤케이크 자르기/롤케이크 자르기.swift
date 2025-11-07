import Foundation
/*
1. 토핑의 수를 Dictionary로 소유하고 갯수를 체크
2. 갯수가 같을 때부터 +1 카운트. 성립되지 않는 포인트를 발견하면 return
*/
func solution(_ topping:[Int]) -> Int {
    var front = [Int: Int]() 
    var back = [Int: Int]()
    var answer = 0
    
    topping.forEach { back[$0, default: 0] += 1 }
    
    for item in topping {
        front[item, default: 0] += 1
        back[item] = (back[item]! > 1) ? back[item]! - 1 : nil
        let isEqual = front.keys.count == back.keys.count
        if isEqual { answer += 1 }
        if answer != 0 && !isEqual { break }        
    }
    
    return answer
}