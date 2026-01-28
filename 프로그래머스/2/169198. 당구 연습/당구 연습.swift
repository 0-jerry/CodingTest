import Foundation

func solution(_ m: Int, _ n: Int, _ startX: Int, _ startY: Int, _ balls: [[Int]]) -> [Int] {
    typealias Point = (x: Int, y: Int)
    
    let start = (x: startX, y: startY)
    let last = (x: m, y: n)
    
    func angle(_ lhs: Point, _ rhs: Point) -> Double {
       Double(lhs.y - rhs.y) / Double(lhs.x - rhs.x)
    }
    func isPass(_ point: Point, _ destination: Point) -> Bool {
        let minX = min(start.x, destination.x)
        let maxX = max(start.x, destination.x)
        let minY = min(start.y, destination.y)
        let maxY = max(start.y, destination.y)
        guard (minX...maxX).contains(point.x),
              (minY...maxY).contains(point.y) else { return false }
        
        return angle(point, destination) == angle(start, destination)
    }
    
    func distance(_ lhs: Point, _ rhs: Point) -> Int {
        let subtractedX = lhs.x - rhs.x
        let subtractedY = lhs.y - rhs.y
        return subtractedX * subtractedX + subtractedY * subtractedY
    }
    
    func reflectedPoint(_ point: Point, _ guide: Point) -> Point {
        
        func reflectValue(_ target: Int, _ guide: Int, _ maximum: Int) -> Int {
            if guide == 0 {
                return target * (-1)
            } else if guide == maximum {
                return 2 * maximum - target
            } else {
                return target
            }
        }
        
        let reflectedX = reflectValue(point.x, guide.x, last.x)
        let reflectedY = reflectValue(point.y, guide.y, last.y)

        return (x: reflectedX, y: reflectedY)
    }

    let side: [Point] = [(0, start.y), 
                         (start.x, 0), 
                         (last.x, start.y), 
                         (start.x, last.y)]
    
    let edge: [Point] = [(0, 0), 
                         (0, last.y), 
                         (last.x, 0), 
                         (last.x, last.y)]
    
    let reflactPoints = side + edge
    let reflactedStart: [Point] = reflactPoints.map { reflectedPoint(start, $0) }

    func minimumDistance(_ target: Point) -> Int {
        var minimum = Int.max
        for (index, reflactPoint) in reflactPoints.enumerated() {
            guard !isPass(target, reflactPoint) else { continue }
            let current = distance(reflactedStart[index], target)
            minimum = min(current, minimum)
        }
        return minimum
    }
    
    return balls.map { minimumDistance(($0[0], $0[1])) }
}