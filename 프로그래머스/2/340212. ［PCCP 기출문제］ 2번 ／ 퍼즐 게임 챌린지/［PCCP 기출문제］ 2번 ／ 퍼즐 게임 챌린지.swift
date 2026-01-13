import Foundation

func solution(_ diffs:[Int], _ times:[Int], _ limit:Int64) -> Int {
    let puzzleCount = diffs.count
    var retryTimes = [Int](repeating: 0, count: puzzleCount)
    var baseTime = times[0]
    var mostDiff = 0
    retryTimes[0] = times[0]
    
    for i in 1..<puzzleCount {
        let current = times[i]
        retryTimes[i] = current + times[i-1]
        baseTime += current
        mostDiff = max(mostDiff, diffs[i])
    }
    
    let remainTime = Int(limit) - baseTime
    
    func calculateTotalTime(_ level: Int) -> Int {
        var total = 0 
        for i in 0..<puzzleCount {
            guard remainTime >= total else { break }
            
            if diffs[i] > level {
                total += (diffs[i] - level) * retryTimes[i]
            }
        }
        
        return total 
    }
    
    var left = 1
    var right = mostDiff
    var answer = right
    
    while left <= right { 
        let mid = (left + right) / 2  
        let totalTime = calculateTotalTime(mid) 
        
        if totalTime <= remainTime {
            answer = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    
    return answer
}