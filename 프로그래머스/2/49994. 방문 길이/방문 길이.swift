import Foundation

typealias point = (x: Int, y: Int)

var walkedRoads = Set<String>()

func checkAvailablePosition(pt: point) -> Bool {
    return (abs(pt.x) <= 5) && (abs(pt.y) <= 5)
}

func walk(before: point, by: point) -> point {
    let new: point = (before.x + by.x, before.y + by.y)
    guard checkAvailablePosition(pt: new) else {
        return before
    }

    let roadX = before.x + new.x
    let roadY = before.y + new.y

    walkedRoads.insert("\(roadX)\(roadY)")

    return new
}

func solution(_ dirs: String) -> Int {
    var position: point = (0, 0)

    dirs.forEach {
        switch $0 {
        case "L":
            position = walk(before: position, by: (-1, 0))
        case "R":
            position = walk(before: position, by: (1, 0))
        case "U":
            position = walk(before: position, by: (0, 1))
        case "D":
            position = walk(before: position, by: (0, -1))
        default:
            break
        }
    }

    return walkedRoads.count
}