import Foundation

func solution(_ myString:String) -> String {
    
    var answer: String = ""
    
    for char in myString {
        if !answer.contains(char) {
            answer.append(char)
        }
    }
    
    return answer
}