import Foundation
/*
한 큐에서 값을 dequeue 해 다른 queue 에 enqueue 할 경우 1회 작업
총합이 더 큰 큐에서 값을 꺼내 이동 

불가능한 경우, 
1. 두 큐의 총합이 홀수인경우
2. 모든 값이 한번씩 이동한 경우 -> 해당 상황에선 동일한 사이클이 반복됨

Queue
총합 카운팅
시작 시점의 카운트 수 이상 dequeue가 이뤄졌는지 
*/
func solution(_ queue1: [Int], _ queue2: [Int]) -> Int {
    var queueA = Queue(queue1)
    var queueB = Queue(queue2)

    guard (queueA.total + queueB.total) % 2 == 0 else { return -1 }
    
    var count = 0
    while !(queueA.isDequeuedAll && queueB.isDequeuedAll) {
        let totalA = queueA.total
        let totalB = queueB.total
        
        guard totalA != totalB else { return count }
        
        var large = totalA > totalB ? queueA : queueB
        var small = totalA < totalB ? queueA : queueB
        
        guard let element = large.dequeue() else { return -1 }
        small.enqueue(element)
        count += 1
    }
    
    return -1
}

class Queue {
    private var elements: [Int?]

    private let factor: Int
    private var index = 0 
    
    var total: Int 
    var isDequeuedAll: Bool {
        factor <= index
    }
    
    init(_ elements: [Int]) {
        self.elements = elements
        self.total = elements.reduce(0, +)
        self.factor = elements.count
    }
    
    func enqueue(_ element: Int) {
        elements.append(element)
        total += element
    }
    
    func dequeue() -> Int? {
        let element = elements[index]
        elements[index] = nil
        if let element = element { total -= element }
        index += 1 
        
        return element
    }
}