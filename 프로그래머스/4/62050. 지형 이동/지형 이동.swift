import Foundation

struct Heap<T> {
  var nodes: [T] = []
  let comparer: (T,T) -> Bool

  var isEmpty: Bool {
      return nodes.isEmpty
  }

  init(comparer: @escaping (T,T) -> Bool) {
      self.comparer = comparer
  }

  func peek() -> T? {
      return nodes.first
  }

  mutating func insert(_ element: T) {
      var index = nodes.count

      nodes.append(element)

      while index > 0, !comparer(nodes[index],nodes[(index-1)/2]) {
          nodes.swapAt(index, (index-1)/2)
          index = (index-1)/2
      }
  }

  mutating func delete() -> T? {
      guard !nodes.isEmpty else {
          return nil
      }

      if nodes.count == 1 {
          return nodes.removeFirst()
      }

      let result = nodes.first
      nodes.swapAt(0, nodes.count-1)
      nodes.popLast()

      var index = 0

      while index < nodes.count {
          let left = index * 2 + 1
          let right = left + 1

          if right < nodes.count {
              if comparer(nodes[left], nodes[right]),
                  !comparer(nodes[right], nodes[index]) {
                  nodes.swapAt(right, index)
                  index = right
              } else if !comparer(nodes[left], nodes[index]){
                  nodes.swapAt(left, index)
                  index = left
              } else {
                  break
              }
          } else if left < nodes.count {
              if !comparer(nodes[left], nodes[index]) {
                  nodes.swapAt(left, index)
                  index = left
              } else {
                  break
              }
          } else {
              break
          }
      }

      return result
  }
}

struct Point: Hashable {
    let x: Int
    let y: Int
}

struct Edge: Hashable, Comparable {
    let begin: Point
    let end: Point
    let cost: Int

    static func < (lhs: Edge, rhs: Edge) -> Bool {
        return lhs.cost < rhs.cost
    }
}

func solution(_ land:[[Int]], _ height:Int) -> Int {
    var result = 0

    var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: land[0].count), count: land.count)

    var pq: Heap<Edge> = Heap(comparer: >)

    visited[0][0] = true

    pq.insert(Edge(begin: Point(x: 0, y: 0), end: Point(x: 0, y: 1), cost: abs(land[0][0] - land[1][0])))
    pq.insert(Edge(begin: Point(x: 0, y: 0), end: Point(x: 1, y: 0), cost: abs(land[0][0] - land[0][1])))

    let dx: [Int] = [1,0,-1,0]
    let dy: [Int] = [0,1,0,-1]

    while let nextEdge = pq.delete() {
        let x = nextEdge.end.x
        let y = nextEdge.end.y

        if visited[y][x] {
            continue
        }

        visited[y][x] = true

        if nextEdge.cost > height {
            result += nextEdge.cost
        }

        for i in 0..<4 {
            let nx = x + dx[i]
            let ny = y + dy[i]

            if nx<0||nx>=visited[0].count||ny<0||ny>=visited.count {
                continue
            }

            if visited[ny][nx] {
                continue
            }

            let edge = Edge(begin: nextEdge.end, end: Point(x: nx, y: ny), cost: abs(land[y][x] - land[ny][nx]))
            pq.insert(edge)

        }

    }


    return result
}