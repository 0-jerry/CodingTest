import Foundation

func solution(_ sales: [Int], _ links: [[Int]]) -> Int { 
    var teams = [[Int]](repeating: [], count: sales.count + 1)
    
    for link in links {
        teams[link[0]].append(link[1])
    }

    typealias LossResult = (minimum: Int, 
                            deltaForLeaderSelect: Int)
    
    func loss(_ leaderID: Int) -> LossResult {
        let teamLeaderSale = sales[leaderID-1]
        var minimumAdditional = teamLeaderSale
        var minimumSum = 0
        
        for memberID in teams[leaderID] {
            var memberSales = 0
            if !teams[memberID].isEmpty {
                let subLoss = loss(memberID)
                minimumSum += subLoss.minimum
                minimumAdditional = min(minimumAdditional, 
                                        subLoss.deltaForLeaderSelect)
            } else {
                minimumAdditional = min(minimumAdditional, sales[memberID-1])
            }
        }
        
        return (
            minimum: minimumSum + minimumAdditional, 
            deltaForLeaderSelect: teamLeaderSale - minimumAdditional
        )
    }
    
    return loss(1).minimum
}