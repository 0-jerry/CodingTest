import Foundation

func solution(_ infos: [String], _ querys: [String]) -> [Int] {
    
    func convert(_ string: String) -> (query: [String], score: Int) {
        var components = string
        .components(separatedBy: " ")
        .filter { $0 != "and" }
        let score = Int(components.removeLast())!
        
        return (components, score)
    }
    
    func makeQuerys(_ query: [String]) -> [String] {
        var querys = [""]
        for string in query {
            querys = querys.map { $0 + string } + querys.map { $0 + "-" }
        }
        return querys
    }
    
    var cachedIndice: [String: [Int]] = [:]

    infos.forEach { info in 
        let converted = convert(info)
        let querys = makeQuerys(converted.query)
        let score = converted.score
        querys.forEach {
            cachedIndice[$0, default: []].append(score)
        }
    }
    
    let sortedScore: [String: [Int]] = {
        var sortedScore: [String: [Int]] = [:]
        for (key, value) in cachedIndice {
            sortedScore[key] = value.sorted()
        }
        return sortedScore
    }()

    func binarySearch(_ array: [Int], _ target: Int) -> Int {
         var left = 0
         var right = array.count - 1
         var answer = array.count
        
         while left <= right {
             let mid = (left + right) / 2
            
             if array[mid] >= target {
                 right = mid - 1
                 answer = mid
             } else {
                 left = mid + 1
             }
         }
        return answer
    }

    return querys.map {
        let converted = convert($0)
        let joinedQuery = converted.query.joined()
        let score = converted.score
        guard let target = sortedScore[joinedQuery] else { return 0 }

        return target.count - binarySearch(target, score)
    }
}
