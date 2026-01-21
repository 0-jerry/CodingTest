import Foundation

func solution(_ word: String) -> Int {
    let maxLength = 5
    var cache = [maxLength: 1]
    
    func dfs(_ digit: Int) -> Int {
        if let cached = cache[digit] {
            return cached 
        } else {
            let current: Int
            if let next = cache[digit + 1] {
                current = 1 + next * 5
            } else {
                current = 1 + 5 * dfs(digit + 1)
            }
            cache[digit] = current
            return current
        }
    }
    
    let indexForAlphabet: [Character: Int] = [
        "A": 1, 
        "E": 2, 
        "I": 3,
        "O": 4, 
        "U": 5
    ]
    
    return word.enumerated()
    .reduce(0) { 
        $0 + (1 + (indexForAlphabet[$1.1]! - 1) * dfs($1.0 + 1)) 
    }
}