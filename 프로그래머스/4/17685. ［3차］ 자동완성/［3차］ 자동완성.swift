import Foundation 

final class TrieNode {
    var child: [Character: TrieNode] = [:]
    private var count: Int = 0
    
    func totalCount() -> Int {
        if count == 1 { 
            return count 
        } else {
            return child.reduce(count) { $0 + $1.value.totalCount() }
        }
    }
    
    func insert(_ chars: inout [Character]) {
        count += 1
        guard !chars.isEmpty else { return }
        let last = chars.removeLast()
        if let nextNode = child[last] {
            nextNode.insert(&chars)
        } else {
            let node = TrieNode()
            node.insert(&chars)
            child[last] = node
        }
    }
}

func solution(_ words: [String]) -> Int {
    let root = TrieNode()
    for word in words {
        var reversedWord = [Character](word.reversed())
        root.insert(&reversedWord)
    }
    return root.totalCount() - words.count 
}
