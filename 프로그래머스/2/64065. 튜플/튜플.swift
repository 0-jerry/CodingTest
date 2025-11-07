import Foundation

func solution(_ s: String) -> [Int] {
    var elements = [Int](repeating: 0, count: 100_001)
    var temp = ""
    
    let separator = Set<Character>(["}", ","])
    for char in s {
        if separator.contains(char) {
            if let int = Int(temp) {
                elements[int] += 1 
                temp = ""
            }
        }
        if char.isNumber { 
            temp.append(char)
        }
    }
    
    return elements.enumerated().filter { $0.1 > 0 }.sorted { $0.1 > $1.1 }.map { $0.0 }
}