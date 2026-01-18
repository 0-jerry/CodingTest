import Foundation

func solution(_ sales: [Int], _ links: [[Int]]) -> Int { 
    
    var teams = [[Int]](repeating: [], count: sales.count + 1)
    // var isLeader = [Bool](repeating: false, count: sales.count + 1)
    
    for link in links {
        let leader = link[0]
        let member = link[1]
        teams[leader].append(member)
        // isLeader[leader] = true
    }
    
    struct TeamInfo {
        let teamNumber: Int
        let justMembers: [Int]
        let subleaders: [Int]
    }
    
    func info(_ teamNumber: Int) -> TeamInfo {
        var justMembers = [Int]()
        var subleaders = [Int]()
        
        teams[teamNumber]
        .forEach { 
            !teams[$0].isEmpty ? subleaders.append($0) : justMembers.append($0) 
        }
        
        return TeamInfo(
            teamNumber: teamNumber, 
            justMembers: justMembers, 
            subleaders: subleaders
        )
    }

    struct TeamReport {
        let teamNumber: Int
        let leaderSelected: Int
        let minimum: Int
        let subtract: Int
        
        init(teamNumber: Int, leaderSelected: Int, minimum: Int) {
            self.teamNumber = teamNumber
            self.leaderSelected = leaderSelected
            self.minimum = minimum
            self.subtract = leaderSelected - minimum
        }
    }
    
    func report(_ teamInfo: TeamInfo) -> TeamReport {
        let leader = teamInfo.teamNumber
        let justMembers = teamInfo.justMembers
        let subleaders = teamInfo.subleaders
        
        var subTeamReports = [TeamReport]()
        var minimumSum = 0
        var minSubtract = Int.max
        
        for subleader in subleaders { 
            let subTeamInfo = info(subleader)
            let subTeamReport = report(subTeamInfo) 
            
            subTeamReports.append(subTeamReport)
            minimumSum += subTeamReport.minimum
            minSubtract = min(subTeamReport.subtract, minSubtract)
        }
        
        let leaderSales = sales[leader-1]
        var minAdd = min(leaderSales, minSubtract)
        
        for justMember in justMembers {
            guard minAdd > 0 else { break }
            minAdd = min(sales[justMember-1], minAdd)
        }
        
        return TeamReport(
                teamNumber: teamInfo.teamNumber,
                leaderSelected: minimumSum + leaderSales,
                minimum: minimumSum + minAdd
        )
    }
    
    let bossInfo = info(1)
    let bossReport = report(bossInfo)
    
    return bossReport.minimum
}