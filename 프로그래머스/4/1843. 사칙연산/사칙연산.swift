import Foundation

func solution(_ input: [String]) -> Int {
    var isPlus = [Bool](repeating: true, count: input.count / 2 )
    var numbers = [Int](repeating: -1, count: input.count / 2 + 1)
    
    for (offset, str) in input.enumerated() {
        let index = offset / 2 
        if offset % 2 == 0 {
            numbers[index] = Int(str)!
        } else if str == "-" {
            isPlus[index] = false 
        }
    }
    
    var minCached = [[Int?]](repeating: [Int?](repeating: nil, 
                                               count: isPlus.count + 1),
                             count: isPlus.count + 1)
    var maxCached = minCached
    
    for i in 0..<numbers.count {
        minCached[i][i] = numbers[i]
        maxCached[i][i] = numbers[i]
    }
    
    func cal(start: Int, end: Int) -> (min: Int, max: Int) {
        if let cachedMin = minCached[start][end], 
           let cachedMax = maxCached[start][end] {
               
            return (cachedMin, cachedMax)
        }
        
        var minimum = Int.max
        var maximum = Int.min
        
        defer {
            minCached[start][end] = minimum
            maxCached[start][end] = maximum
        }
        
        for index in start..<end {
            let lhs = cal(start: start, end: index)
            let rhs = cal(start: index + 1, end: end)
            
            if isPlus[index] {
                minimum = min(minimum, (lhs.min + rhs.min))
                maximum = max(maximum, (lhs.max + rhs.max))
            } else {
                minimum = min(minimum, (lhs.min - rhs.max))
                maximum = max(maximum, (lhs.max - rhs.min))
            }
        }
        
        return (minimum, maximum)
    }
    
    return cal(start: 0, end: isPlus.count).max
}