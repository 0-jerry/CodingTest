import Foundation

func solution(_ land: [[Int]], _ height: Int) -> Int {
    let length = land.count

    struct Route {
        let points: (Int, Int)
        let cost: Int

        init(points: (Int, Int), cost: Int) {
            self.points = (min(points.0, points.1), max(points.0, points.1))
            self.cost = cost
        }
    }
    
    let routes: [Route] = { 
        var routes = [Route]() 
        var isVisited: [[Int]] = [[Int]](repeating: [], count: length * length)
        let direction = [(0, 1), (1, 0), (-1, 0), (0, -1)]

        func flatIndex(_ x: Int, _ y: Int) -> Int? {
            guard x >= 0 && x < length && y >= 0 && y < length else {
                return nil 
            }
            return x + y * length
        }
        
        func calCost(_ lhs: (Int, Int), _ rhs: (Int, Int)) -> Int {
            let sub = abs(land[lhs.1][lhs.0] - land[rhs.1][rhs.0])
            return sub > height ? sub : 0
        }
        
        func calRoutes(_ x: Int , _ y: Int) -> [Route] {
            guard let index = flatIndex(x, y) else { return [] }
            return direction
            .compactMap { 
                dirX, dirY in 
                let newX = x + dirX
                let newY = y + dirY
                guard let surround = flatIndex(newX, newY), 
                      !isVisited[surround].contains(index) else { 
                    return nil 
                }
                let cost = calCost((x, y), (newX, newY))
                isVisited[index].append(surround)
                return Route(points: (index, surround), cost: cost)
            }
        }
        
        for y in 0..<length {
            for x in 0..<length {
                calRoutes(x, y).forEach {
                    routes.append($0)
                }
            }
        }
        
        return routes.sorted { $0.cost < $1.cost }
    }()
    
    var parents: [Int] = Array(0...length*length-1)
    var totalCost = 0
    
    func find(_ index: Int) -> Int {
        if parents[index] == index {
            return index
        } else {
            return find(parents[index])
        }
    }
    
    func combine(_ route: Route) {
        let lhs = find(route.points.0)
        let rhs = find(route.points.1)
        if lhs == rhs {
            return 
        } else {
            parents[rhs] = lhs
            parents[route.points.0] = lhs
            parents[route.points.1] = lhs
            totalCost += route.cost
        }
    }
    
    routes.forEach { combine($0) }
    
    return totalCost
}