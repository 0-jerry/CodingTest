import Foundation

func solution(_ a: Int, _ b: Int) -> Int {
    let value1 = Int(String(a) + String(b)) ?? 0 
    let value2 = Int(String(b) + String(a)) ?? 0
    return max(value1, value2)
}