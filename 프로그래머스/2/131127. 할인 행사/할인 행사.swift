import Foundation

func solution(_ want:[String], _ number:[Int], _ discount:[String]) -> Int {
    
    var answer = 0
    var wantDict: [String: Int] = [:]
    
    for i in 0..<want.count {
        wantDict[want[i]] = number[i]
    }
        
    
    for i in 0..<(discount.count - 9) {
        var discountDict: [String: Int] = [:]
        for j in 0...9 {
            discountDict[discount[i+j]] = (discountDict[discount[i+j]] ?? 0) + 1
        }
        
        if wantDict == discountDict {
            answer += 1
        }
    }
    
    return answer
}