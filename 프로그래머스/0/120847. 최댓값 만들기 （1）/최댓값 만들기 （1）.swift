import Foundation

func solution(_ numbers:[Int]) -> Int {
    let sorted = numbers.sorted(by: >)
    return sorted[0] * sorted[1]
}