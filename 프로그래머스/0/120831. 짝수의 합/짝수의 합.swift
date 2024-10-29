import Foundation

func solution(_ n:Int) -> Int {
    (0...n/2).reduce(0,+) * 2
}