import Foundation

func solution(
    _ remainGold: Int, _ remainSilver: Int, 
    _ golds: [Int], _ silvers: [Int], 
    _ weights: [Int], _ times: [Int]
) -> Int64 {
    var maximumTime = 0
    let remainMineral = remainGold + remainSilver
    for cityID in 0..<weights.count {
        let weight = weights[cityID]
        let totalMineral = golds[cityID] + silvers[cityID]
        let moveCount = (totalMineral + weight - 1) / weight
        let current = (moveCount * 2 - 1) * times[cityID]

        maximumTime = max(maximumTime, current)
    }
    
    func isComplet(_ currentTime: Int) -> Bool {
        var totalGold = 0
        var totalSilver = 0
        var totalMineral = 0
        
        for cityID in 0..<weights.count {
            let cityGold = golds[cityID]
            let citySilver = silvers[cityID]
            
            let travelTime = times[cityID]
            let weightLimit = weights[cityID]
            
            let moveCount = (currentTime + travelTime) / (travelTime * 2)
            let maxPayload = moveCount * weightLimit
            
            totalGold += min(cityGold, maxPayload)
            totalSilver += min(citySilver, maxPayload)
            totalMineral += min(cityGold + citySilver, maxPayload)
        }
        
        let isEnoughtGold: Bool = remainGold <= totalGold 
        let isEnoughtSilver: Bool = remainSilver <= totalSilver
        let isEnoughtMineral: Bool = remainMineral <= totalMineral
        
        return isEnoughtGold && isEnoughtSilver && isEnoughtMineral
    }

    guard let targetTime = binarySearch(0, maximumTime, isComplet) else {
        return -1
    }
    return Int64(targetTime)
}


func binarySearch(_ start: Int, _ end: Int, _ closure: (Int) -> Bool) -> Int? {
    var left = start
    var right = end
    var answer: Int? = nil
    
    while left <= right {
        let mid = (left + right) / 2

        if closure(mid) {
            answer = mid
            right = mid - 1 
        } else {
            left = mid + 1
        }
    }
            
    return answer
}