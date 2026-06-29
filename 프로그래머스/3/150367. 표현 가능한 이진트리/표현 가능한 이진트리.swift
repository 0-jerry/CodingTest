import Foundation

func solution(_ numbers: [Int64]) -> [Int] {
    numbers.map { FullBinaryTree(Int($0)).isValid() ? 1 : 0 }
}

struct FullBinaryTree {
    init(_ value: Int) {
        var count = 0 
        var value = value
        var length = 1
        var rawElements = [Bool]()
        while value > 0 {
            let isOdd = value % 2 == 1
            if isOdd { count += 1 }
            rawElements.append(isOdd)
            value /= 2
        }
        
        while rawElements.count > length {
            length = (length + 1) * 2 - 1 
        }
        
        self.elements = rawElements + [Bool](repeating: false, count: length - rawElements.count)
        self.count = count 
    }
    
    private let elements: [Bool]
    private let count: Int
    
    func isValid() -> Bool {
        count == scanNodeCount(0, elements.count-1)
    }
    
    private func scanNodeCount(_ start: Int, _ end: Int) -> Int {
        guard start != end else {
            return elements[start] ? 1 : 0 
        }
        
        let current = (start + end) / 2
        if elements[current] {
            return scanNodeCount(start, current - 1) + scanNodeCount(current + 1, end) + 1
        } else {
            return 0
        }
    }
}
