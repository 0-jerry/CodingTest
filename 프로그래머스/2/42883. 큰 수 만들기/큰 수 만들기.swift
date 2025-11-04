import Foundation

func solution(_ number: String, _ k: Int) -> String {
    var stack: [Character] = []
    var flag = k
    for char in number {
        while let last = stack.last, last < char, flag > 0 {
            stack.removeLast()
            flag -= 1
        }
        
        stack.append(char)
    }
    
    if flag > 0 {
        stack.removeLast(flag)
    }
    
    return String(stack)
    
}