import Foundation

func solution(_ want:[String], _ number:[Int], _ discount:[String]) -> Int {
    var answer = 0
    var wantDict = [String: Int]()
    
    for i in 0..<want.count {
        wantDict[want[i]] = number[i]
    }
    
    var discountDict = [String: Int]()
    
    for i in 0..<discount.count {
        discountDict[discount[i], default: 0] += 1 
        if i >= 10 { 
            if discountDict[discount[i-10]] == 1 { 
                discountDict[discount[i-10]] = nil 
            } else {
            discountDict[discount[i-10], default: 0] -= 1 
            }
        }
        if wantDict == discountDict { answer += 1 }
    }
    
    return answer
}