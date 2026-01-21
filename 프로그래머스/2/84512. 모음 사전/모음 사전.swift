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
    
    let vowels: [Character] = ["A", "E", "I", "O", "U"]
    
    return word.enumerated().reduce(0) { sum, element in
        let (index, char) = element
        
        guard let vowelIndex = vowels.firstIndex(of: char) else {
            return sum
        }
        
        let contribution = 1 + vowelIndex * dfs(index + 1)
        return sum + contribution
    }
}
