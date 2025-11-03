
func solution(_ n:Int) -> Int {
    var memo: [Int: Int] = [:]
    
    func fibonacciTopDown(_ n: Int) -> Int {
            guard n > 1 else { 
                    return n 
            }

            if let cached = memo[n] {
                    return cached 
            }

            let result = (fibonacciTopDown(n - 1) + fibonacciTopDown(n - 2)) % 1234567
            memo[n] = result
            return result
    }

    return fibonacciTopDown(n)
}
