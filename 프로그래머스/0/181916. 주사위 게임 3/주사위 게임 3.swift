import Foundation

func solution(_ a: Int, _ b: Int, _ c: Int, _ d: Int) -> Int {
    
    var answer = Int.max
    
    let numbers: [(number: Int, count: Int)] = { 
        var slot = [Int](repeating: 0, count: 7)
        [a, b, c, d].forEach { slot[$0] += 1 }
        return slot
        .enumerated()
        .compactMap { $0.element != 0 ? ($0.offset, $0.element) : nil }
    }()
    
    if numbers.count == 1 {
        answer = numbers[0].number * 1111
        
    } else if numbers.count == 2 {
        if numbers[0].count == numbers[1].count {
            let p = numbers[0].number
            let q = numbers[1].number
            answer = (p + q) * abs(p - q)
        } else {
            let sorted = numbers.sorted { $0.count > $1.count }
            let p = sorted[0].number
            let q = sorted[1].number
            answer = ( 10 * p + q ) * ( 10 * p + q )
        }
        
    } else if numbers.count == 3 {
        answer = numbers
                  .filter { $0.count == 1 }
                  .reduce(1) { $0 * $1.number }
        
    } else {
        numbers.forEach { answer = min(answer, $0.number) }
    }
    
    return answer
}