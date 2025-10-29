import Foundation

func solution(_ myString: String) -> String {
    var answer = ""
    
    for char in myString {
        answer.append(char.uppercased())
    }
    
    return answer
}