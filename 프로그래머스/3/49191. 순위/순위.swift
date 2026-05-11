import Foundation

func solution(_ n: Int, _ results: [[Int]]) -> Int {

    var front: [Set<Int>] = .init(repeating: [], count: n+1)
    var behind: [Set<Int>] = .init(repeating: [], count: n+1)

    func update(_ winner: Int, _ loser: Int) {
        var newLoser = behind[loser]
        newLoser.insert(loser)
        
        var newWinner = front[winner]
        newWinner.insert(winner)
        
        for i in newWinner {
            behind[i] = behind[i].union(newLoser)
        }
        
        for i in newLoser {
            front[i] = front[i].union(newWinner)
        }
    }
    
    for result in results {
        let winner = result[0]
        let loser = result[1]
        update(winner, loser)
    }
    
    var answer = 0 
    
    for i in 1...n {
       if (front[i].count + behind[i].count) == n-1 {
           answer += 1
       }
    }
    
    return answer
}