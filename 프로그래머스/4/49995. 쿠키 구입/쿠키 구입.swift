import Foundation

func solution(_ cookie: [Int]) -> Int {
    typealias Bucket = (sum: Int, start: Int, end: Int)
    var answer = 0
    let lastIndex = cookie.count-1
    
    var left: Bucket = (cookie.reduce(0, +) - cookie[lastIndex], 0, lastIndex - 1)
    var right: Bucket = (cookie[lastIndex], lastIndex, lastIndex)
    
    while left.end >= 0, left.sum > answer {
        var newLeft = left
        var newRight = right 
        
        while newRight.sum > answer {
            if newLeft.sum == newRight.sum {
                answer = newRight.sum
                break 
            } else if newLeft.sum < newRight.sum {
                newRight.sum -= cookie[newRight.end]
                newRight.end -= 1
                if newRight.sum == 0 { break }
            } else {
                newLeft.sum -= cookie[newLeft.start]
                newLeft.start += 1
                if newLeft.sum == 0 { break }
            }
        }
        
        let centerCookie = cookie[left.end]
        left.sum -= centerCookie
        left.end -= 1
        right.sum += centerCookie
        right.start -= 1
    }
    
    return answer
}