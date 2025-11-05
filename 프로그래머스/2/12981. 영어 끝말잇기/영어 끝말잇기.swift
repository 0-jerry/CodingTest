import Foundation

func solution(_ n: Int, _ words: [String]) -> [Int] {
    var index = 0
    var first: Character? = words[0].first
    var used = Set<String>()
    
    for word in words {
        guard word.first == first, !used.contains(word) else { 
            return [index % n + 1, index / n + 1] 
        }
        used.insert(word)
        first = word.last
        index += 1 
    }   

    return [0, 0]
}