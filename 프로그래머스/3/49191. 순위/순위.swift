import Foundation

func solution(_ n:Int, _ results:[[Int]]) -> Int {
    
    var win: [[Bool]] = {
        let temp = [Bool](repeating: false, count: n+1) 
        return [[Bool]](repeating: temp, count: n+1)
    }()
    
    var lose = win
    
    func connect(_ winner: Int, _ loser: Int) {
        win[winner][loser] = true
        lose[loser][winner] = true
    }
    
    for result in results {
        connect(result[0], result[1])
    }
    
    for mid in 1...n {
        for start in 1...n {
            for end in 1...n {
                guard !(win[start][end] && lose[start][end]) else { continue }
                
                if win[start][mid] && win[mid][end] {
                    connect(start, end)
                } else if lose[start][mid] && lose[mid][end] {
                    connect(end, start)
                }
            }
        }
    }
    
    var answer = 0
    
    for i in 1...n {
        var connected = true 
        for j in 1...n {
            guard i == j || win[i][j] || lose[i][j] else {
                connected = false
                break
            }
        }
        if connected { answer += 1 }
    }
    win.forEach {print($0)} 
    print()
    lose.forEach {print($0)}
    return answer
}