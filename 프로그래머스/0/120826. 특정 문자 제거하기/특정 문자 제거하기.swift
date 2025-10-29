import Foundation

func solution(_ my_string: String, _ letter: String) -> String {
    var answer = ""
    let charLetter = Character(letter)
    for char in my_string {
        if charLetter != char {
            answer.append(char)
        }
    }
    
    return answer
}