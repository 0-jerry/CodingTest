import Foundation

func solution(_ user_id:[String], _ banned_id:[String]) -> Int {
    let userID = user_id.map { Array($0) }
    let bannedID = banned_id.map { Array($0) }
    var candidates = [[Int]](repeating: [], count: bannedID.count)
    var combinationSet = Set<[Int]>()
    var output = 0

    func compare(_ lhs: [Character], _ rhs: [Character]) -> Bool {
        guard lhs.count == rhs.count else { return false }

        for (lhsChar, rhsChar) in zip(lhs, rhs) {
            guard rhsChar == "*" || lhsChar == rhsChar else { return false }
        }
        return true
    }

    func combination(_ count: Int, _ selected: Set<Int>, _ candidates: inout [[Int]]) {
        guard count != bannedID.count else {
            output += (combinationSet.insert(selected.sorted()).inserted) ? 1 : 0
            return
        }

        candidates[count].forEach {
            var selected = selected
            guard selected.insert($0).inserted else { return }
            combination(count+1, selected, &candidates)
        }
    }

    bannedID.enumerated().forEach { index, id in
        candidates[index] = userID.enumerated()
                                   .filter { compare($1, id) }
                                   .map { $0.offset }
    }

    combination(0, Set<Int>(), &candidates)

    return output
}