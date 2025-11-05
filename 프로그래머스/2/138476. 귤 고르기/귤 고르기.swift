import Foundation

func solution(_ k:Int, _ tangerine:[Int]) -> Int {
    var tangerineDict = [Int: Int]()
    var answer = 0
    var k = k
    for i in tangerine {
        tangerineDict[i, default: 0] += 1
    }
    
    var sorted = tangerineDict.sorted { $0.value > $1.value }
    
    for i in sorted {
        k -= i.value ?? 0 
        answer += 1
        if k <= 0 { break }
    }
    
    return answer
}