import Foundation

func solution(_ number: String, _ k: Int) -> String {
    var removedCount = 0 
    var stack = Stack()
    
    func push(_ value: Character) {        
        while removedCount < k && stack.isPushable(value) {
            guard stack.pop() != nil else {
                break
            }
            removedCount += 1
        }
        
        stack.push(value)
    }
    
    for char in number {
        push(char)
    }
    
    while removedCount < k {
        let _ = stack.pop()
        removedCount += 1
    }
    
    return stack.joined()
}

struct Stack {
    
    private var values: [Character] = []
    
    func joined() -> String {
        String(values)
    }
    
    func isPushable(_ value: Character) -> Bool {
        guard let last = values.last else { return true }
        return last < value
    }
    
    mutating func push(_ value: Character) {
        values.append(value)
    }
    
    mutating func pop() -> Character? {
        guard !values.isEmpty else { return nil }
        return values.removeLast()
    }
    
}