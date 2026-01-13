import Foundation

func solution(_ diffs:[Int], _ times:[Int], _ limit:Int64) -> Int {
    let puzzleCount = diffs.count
    var retryTimes = [Int64](repeating: 0, count: puzzleCount) 
    var baseTime: Int64 = Int64(times[0])
    
    retryTimes[0] = Int64(times[0])
    
    for i in 1..<puzzleCount {
        let current = Int64(times[i])
        retryTimes[i] = current + Int64(times[i-1])
        baseTime += current
    }
    
    let remainTime = limit - baseTime
    
    func calculateRetryTime(_ level: Int) -> Int64 {
        var total: Int64 = 0
        
        for i in 0..<puzzleCount {
            if diffs[i] > level {
                total += Int64(diffs[i] - level) * retryTimes[i]
            }
            
            if total > remainTime {
                return total
            }
        }
        
        return total
    }
    
    var left = 1
    var right = diffs.max() ?? 1
    var answer = right
    
    while left <= right {
        let mid = (left + right) / 2
        let retryTime = calculateRetryTime(mid)
        
        if retryTime <= remainTime {
            answer = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    
    return answer
}