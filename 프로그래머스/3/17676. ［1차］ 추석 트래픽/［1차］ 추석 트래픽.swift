import Foundation

func solution(_ lines: [String]) -> Int {
    
    struct TimeSlot {
        let start: Int
        let finish: Int
        
        init(_ finishTime: Int, _ takeTime: Int) {
            self.start = max((finishTime - takeTime + 1), 0)
            self.finish = finishTime
        }
        
        func isOverlap(_ other: TimeSlot) -> Bool {
            start <= other.finish && other.start <= finish          
        }
    }
    
    func second(_ string: String) -> Int {
        var rawValue = string.filter { ![".", "s"].contains($0) }
        
        while rawValue.count < 4 {
            rawValue += "0"
        }
        
        return Int(rawValue) ?? 0
    }
    
    func wholeTimeRaw(_ string: String) -> Int {
        let timeValue = [3_600_000, 60_000]
        let components = string.components(separatedBy: ":")
        
        var rawValue = 0
        
        rawValue += (Int(components[0]) ?? 0) * 3_600_000
        rawValue += (Int(components[1]) ?? 0) * 60_000
        rawValue += second(components[2])
        
        return rawValue
    }
    
    var timeSlots = [TimeSlot]()
    var checkTimeSlots = [TimeSlot]()
    
    for line in lines { 
        let components = line.components(separatedBy: " ")
        let finish = wholeTimeRaw(components[1])
        let takeTime = second(components[2])
        timeSlots.append(TimeSlot(finish, takeTime))
        checkTimeSlots.append(TimeSlot(finish + 999, 1000))
    }
    
    var maximum = 0
    
    checkTimeSlots.forEach { checkTimeSlot in
        let count = timeSlots.filter { $0.isOverlap(checkTimeSlot) }.count
        maximum = max(maximum, count)
    }
    
    return maximum
}