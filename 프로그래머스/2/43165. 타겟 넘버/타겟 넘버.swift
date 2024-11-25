func solution(_ numbers:[Int], _ target:Int) -> Int {

    var answer = 0
    
    func dfs(_ index: Int, _ value: Int) {
        guard numbers.count > index else { 
            if target == value { answer += 1 }
        return 
        }
        
        let operationValue = numbers[index]
        let index = index + 1
        
        dfs(index, value + operationValue)
        dfs(index, value - operationValue)
    }
    
    dfs(0,0)
    
    return answer
}