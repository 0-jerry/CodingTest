import Foundation

func solution(_ my_string: String, _ n: Int) -> String {
    var answer = ""
    let startIndex = my_string.count - n
    
    for char in my_string.enumerated() {
        if char.offset >= startIndex {
            answer.append(char.element)
        }
    }
    
    return answer
}