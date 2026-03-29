import Foundation

func solution(_ cookie: [Int]) -> Int {
    typealias Bucket = (sum: Int, start: Int, end: Int)
    var answer = 0
    let lastIndex = cookie.count-1
    var firstBucket: Bucket = (cookie.reduce(0, +) - cookie[lastIndex], 0, lastIndex - 1)
    var secondBucket: Bucket = (cookie[lastIndex], lastIndex, lastIndex)
    
    while firstBucket.end >= 0, firstBucket.sum > answer {
        var newFirstBucket = firstBucket
        var newSecondBucket = secondBucket 
        
        while newSecondBucket.sum > answer {
            if newFirstBucket.sum == newSecondBucket.sum {
                answer = newFirstBucket.sum
                break 
            } else if newFirstBucket.sum < newSecondBucket.sum {
                newSecondBucket.sum -= cookie[newSecondBucket.end]
                newSecondBucket.end -= 1
                if newSecondBucket.sum == 0 { break }
            } else {
                newFirstBucket.sum -= cookie[newFirstBucket.start]
                newFirstBucket.start += 1
                if newFirstBucket.sum == 0 { break }
            }
        }
        
        let centerCookie = cookie[firstBucket.end]
        firstBucket.sum -= centerCookie
        firstBucket.end -= 1
        secondBucket.sum += centerCookie
        secondBucket.start -= 1
    }
    
    return answer
}