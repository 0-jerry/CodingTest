import Foundation
/*
m명 늘어날때마다 서버 1대 추가 필요 (m명 미만이라면 서버 증설 불필요)
이용자수가, n*m..<(n+1)*m (m) -> 증설된 서버의 수 == n

m - 팩터값 (서버당 출력으로 생각)
k - 서버 증설 시 사용 시간

16~17 -> 이용자 수 = 2, 이전 증설된 서버로 인해 서버 1개 추가되m어있음
17~18 -> 이용자수 = 13 >> (이용자 수) / m + ( (이용자 수) % m == 0 ? 0 : 1 ) <= n

시간대별 증설 서버를 측정해야한다. 

1. schedule 을 통해 증설된 서버의 수를  확인하고, 추가해야하는 경우 전체 범위에 대해서 추가 
*/
func solution(_ players: [Int], _ m: Int, _ k: Int) -> Int {
    var schedule = Array<Int>(repeating: 0, count: 24)
    var count = 0
    
    func addServer(at currentTime: Int, with addCount: Int) {
        for time in currentTime..<min(24, currentTime + k) {
            schedule[time] += addCount
        }
        count += addCount
    }
    
    for playerCount in players.enumerated() {
        let server = schedule[playerCount.offset]
        let n = playerCount.element / m
        
        if server < n {
            addServer(at: playerCount.offset, with: n - server)
        }
    }
    return count
}