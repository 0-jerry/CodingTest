import Foundation

func solution(_ numbers: [Int64]) -> [Int] {
    numbers.map { FullBinaryTree(Int($0)).isValid() ? 1 : 0 }
}

struct FullBinaryTree {
    init(_ value: Int) {
        var count = 0 
        var value = value
        var maxValue = 1
        var length = 1
        var rawElements = [Bool]()
        
        while value > maxValue { maxValue *= 2 }
        
        while maxValue > 1 {
            maxValue /= 2
            rawElements.append(value >= maxValue)
            if value >= maxValue {
                count += 1
                value -= maxValue
            }
        }
        
        while rawElements.count > length {
            length = (length + 1) * 2 - 1 
        }
        
        self.elements = [Bool](repeating: false, count: length - rawElements.count) + rawElements
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
