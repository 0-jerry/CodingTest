import Foundation

func solution(_ s1: [String], _ s2: [String]) -> Int {
    let set1 = Set(s1)
    
    return s2.filter { set1.contains($0) }.count
}