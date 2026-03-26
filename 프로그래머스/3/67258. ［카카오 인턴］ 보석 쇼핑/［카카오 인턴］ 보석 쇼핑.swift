import Foundation

typealias Range = (start: Int, end: Int)

func solution(_ gems: [String]) -> [Int] {
    
    let allCases: [String] = {
        var allCases = Set<String>()
        gems.forEach { allCases.insert($0) }
        return Array<String>(allCases)
    }()
    let slot = Slot(allCases)
    var answer: Range =  (1, gems.count)
    
    func shortRange(_ lhs: Range, _ rhs: Range) -> Range {
        (lhs.end - lhs.start) <= (rhs.end - rhs.start) ? lhs : rhs
    }
    
    for element in gems {
        slot.append(element)
        
        guard let newAnswer = slot.tightRange() else { continue }
        answer = shortRange(answer, newAnswer)
        
        if (answer.end - answer.start) == allCases.count - 1 { 
            break 
        }
    }
    
    return [answer.start, answer.end]
}

final class Slot {
    private let allCases: [String]
    private var elements: [String] = []
    private var index = 0
    private var elementsCount: [String: Int] = [:]
    private var selectedCount: Int = 0
    var isCompleted: Bool = false
    
    private var isClearable: Bool {
        (elements.count >= index) && 
        (elementsCount[elements[index], default: 0] > 1)
    }
    
    init(_ allCases: [String]) {
        self.allCases = allCases
    }
    
    func append(_ element: String) {
        elementsCount[element, default: 0] += 1 
        
        if elementsCount[element] == 1 {
            selectedCount += 1
            isCompleted = (selectedCount == allCases.count)
        } 
        
        elements.append(element)
    }
    
    func tightRange() -> Range? {
        guard isCompleted else { return nil }
        
        while isClearable {
            elementsCount[elements[index], default: 0] -= 1 
            index += 1
        }
        
        return (index + 1, elements.count)
    }
    
}