import Foundation

func solution(_ tickets: [[String]]) -> [String] {
    var ticketInfos = [String: [TicketInfo]]()
    let visitedTemp = [Bool](repeating: false, count: tickets.count)
    let maxRouteCount = tickets.count + 1 
    
    for (index, ticket) in tickets.enumerated() {
        let start = ticket[0]
        let end = ticket[1]
        let ticketInfo = TicketInfo(index: index, end: end)
        ticketInfos[start, default: []].append(ticketInfo)
    }
    
    var route = [String]()
    
    func dfs(_ currentRoute: [String], _ visited: [Bool]) {
        if currentRoute.count == maxRouteCount {
            guard !route.isEmpty else {
                route = currentRoute 
                return
            }
            for i in 0..<maxRouteCount {
                guard route[i] != currentRoute[i] else { continue }
                if route[i] < currentRoute[i] {
                    break
                } else {
                    route = currentRoute
                }
            }
            return 
        }
        
        guard let last = currentRoute.last, 
              let currentTicketInfos = ticketInfos[last] else { return }
        
        for ticketInfo in currentTicketInfos {
            let index = ticketInfo.index
            guard !visited[index] else { continue }
            var newRoute = currentRoute
            var newVisited = visited
            newVisited[index] = true
            newRoute.append(ticketInfo.end)
            
            dfs(newRoute, newVisited)
        }
    }
    
    dfs(["ICN"], visitedTemp)
    
    return route
}

struct TicketInfo {
    let index: Int
    let end: String
}