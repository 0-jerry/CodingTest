
func solution(_ number: String, _ k: Int) -> String {
    var result: [Int] = []
    var count: Int = 0

    Array(number).compactMap { Int(String($0)) }.forEach { item in
        while count < k {
            if let last = result.last, last < item {
                result.popLast()
                count += 1
            } else {
                break
            }
        }
        result.append(item)
    }

    return result[0..<(result.count - k + count)].map { "\($0)" }.joined()
}
