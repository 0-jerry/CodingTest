import Foundation

func solution(_ maps:[String]) -> [Int] {
    // 기본 상수 설정
    let rowLength = maps.count                    // O(1)
    let columnLength = maps[0].count              // O(1)
    let charMaps = maps.map { [Character]($0) }   // O(n*m) - 2차원 배열 변환
    
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: columnLength), 
                          count: rowLength)       // O(n*m) - 2차원 배열이 더 직관적
    var result = [Int]()                          // 결과 저장
    
    // 상하좌우 이동 벡터
    let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]  // O(1)
    
    /**
     BFS로 연결된 섬 탐색 및 식량 합계 계산
     - 시간복잡도: O(섬의 크기) - 각 셀을 한 번씩만 방문
     - 공간복잡도: O(섬의 크기) - 큐의 최대 크기
     */
    func bfs(_ startRow: Int, _ startCol: Int) -> Int {
        var queue = [(startRow, startCol)]        // O(1) - 큐 초기화
        var queueIndex = 0                        // ✅ removeFirst() 대신 인덱스 사용
        var foodSum = 0                           // 식량 합계
        
        visited[startRow][startCol] = true        // O(1) - 시작점 방문 처리
        foodSum += Int(String(charMaps[startRow][startCol]))!  // O(1)
        
        // ⏱️ O(섬의 크기) - 각 셀을 한 번씩만 방문
        while queueIndex < queue.count {
            let (row, col) = queue[queueIndex]    // O(1) - 큐에서 꺼내기
            queueIndex += 1                       // O(1) - 인덱스 증가
            
            // ⏱️ O(4) = O(1) - 상하좌우 4방향 탐색
            for (dr, dc) in directions {
                let newRow = row + dr             // O(1)
                let newCol = col + dc             // O(1)
                
                // 범위 체크 및 방문 여부 확인
                // O(1) - 모든 조건 체크
                guard newRow >= 0 && newRow < rowLength &&
                      newCol >= 0 && newCol < columnLength &&
                      !visited[newRow][newCol] &&
                      charMaps[newRow][newCol] != "X" else {
                    continue
                }
                
                visited[newRow][newCol] = true    // O(1) - ✅ 큐 삽입 시 즉시 방문 처리
                queue.append((newRow, newCol))    // O(1) amortized
                foodSum += Int(String(charMaps[newRow][newCol]))!  // O(1)
            }
        }
        
        return foodSum  // O(1)
    }
    
    // ⏱️ O(n*m) - 모든 셀을 한 번씩 확인
    for row in 0..<rowLength {
        for col in 0..<columnLength {
            // 방문하지 않은 육지를 발견하면 BFS 시작
            // O(1) - 조건 체크
            if !visited[row][col] && charMaps[row][col] != "X" {
                let foodSum = bfs(row, col)       // O(섬의 크기)
                result.append(foodSum)            // O(1) amortized
            }
        }
    }
    
    // ⏱️ O(k * log(k)) - k: 섬의 개수 (최대 n*m)
    return result.isEmpty ? [-1] : result.sorted()  // O(k * log(k))
}

// 전체 시간복잡도: O(n*m + k*log(k)) ≈ O(n*m)
// 전체 공간복잡도: O(n*m)