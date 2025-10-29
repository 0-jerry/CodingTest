import Foundation

func solution(_ my_string: String, _ n: Int) -> String {
    var answer = ""
    
    for char in my_string {
        guard answer.count < n else { break }
        answer.append(char)
    }
    
    return answer
}