import Foundation

func solution(_ my_string:String) -> Int {
    var sum = 0
    for char in my_string {
        if let value = Int(String(char)) { sum += value }
    }
    return sum
}