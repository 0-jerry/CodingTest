import Foundation

func solution(_ n: Int, _ t: Int, _ m: Int, 
              _ timetable: [String]) -> String {    
    func toMinute(_ string: String) -> Int {
        zip(
            string.compactMap { $0.wholeNumberValue }, 
            [600, 60, 10, 1]
        ).reduce(0) { $0 + ( $1.0 * $1.1 ) }
    }
    
    func format(_ minute: Int) -> String {
        String(format: "%02d:%02d", minute / 60, minute % 60)
    }
    
    var index = 0
    let sortedMinuteTable = timetable.map { toMinute($0) }.sorted()
    var timeSlot = [Int]()
    var currentTime = 9 * 60
    var count = 0 
    
    while count < n {
        timeSlot = [Int]()
        
        while timeSlot.count < m && index < sortedMinuteTable.count {
            guard sortedMinuteTable[index] <= currentTime else { 
                break 
            }
            timeSlot.append(sortedMinuteTable[index])
            index += 1
        }
        count += 1
        currentTime += t
    }
    
    guard timeSlot.count == m,
          let lastTime = timeSlot.last else { 
        return format(currentTime - t)
    }

    return format(lastTime - 1)
}