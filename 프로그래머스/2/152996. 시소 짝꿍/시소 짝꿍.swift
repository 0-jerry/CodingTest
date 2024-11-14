
func solution(_ weights:[Int]) -> Int64 {
    
    //반환할 커플 수 
    var countOfCouple: Int = 0
    
    
    //동일 몸무게의 사람 수를 저장 <몸무게, 사람 수>
    var countOfWeights: [Int: Int] = [:]
    
    for weight in weights {
        countOfWeights[weight, default: 0] += 1
    }
    
    //몸무게 중복제거 배열
    let compressedWeights = countOfWeights.keys.map { Int($0) }
    
    //동일 몸무게 커플 수 연산
    for weight in compressedWeights {
        let countOfWeight = countOfWeights[weight, default: 0]
        countOfCouple += countOfWeight * (countOfWeight-1) / 2
    }
    
    //균형을 잡을 수 있는 몸무게들을 판단해, 커플 수 연산
    for i in 0..<compressedWeights.count-1 {
        for j in i+1..<compressedWeights.count {
            let lhs = compressedWeights[i]
            let rhs = compressedWeights[j]
            
            if balanceable(lhs,rhs) {
                countOfCouple += (countOfWeights[lhs, default: 0] * countOfWeights[rhs, default: 0])
            }
        }
    }
    return Int64(countOfCouple)
}

//길이 비율 Set
let ratios: Set<Double> = [2, 4/3, 3/2]

//균형 잡기 가능 여부 판단
func balanceable(_ lhs: Int, _ rhs: Int) -> Bool {
    let maxInt = max(lhs, rhs)
    let minInt = min(lhs, rhs)
    
    let max = Double(maxInt)
    let min = Double(minInt)
    
    return ratios.contains(max/min)
}
