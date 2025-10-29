import Foundation

let n = Int(readLine()!)!

var arr = [String]()

for i in 1...n {
    arr.append(String(repeating: "*", count: i))
}
let triangle = arr.joined(separator: "\n")
print(triangle)