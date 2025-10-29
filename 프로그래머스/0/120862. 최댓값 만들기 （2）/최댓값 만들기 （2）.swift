import Foundation

func solution(_ numbers:[Int]) -> Int {
    let sorted = numbers.sorted()
    return max(sorted[0] * sorted[1], sorted[sorted.count-2] * sorted[sorted.count-1])
}