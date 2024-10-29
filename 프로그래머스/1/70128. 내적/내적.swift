import Foundation

func solution(_ a:[Int], _ b:[Int]) -> Int {
    (0..<a.count).reduce(0, { $0 + a[$1] * b[$1] })
}