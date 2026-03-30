import Foundation

func solution(
    _ enrolls: [String], 
    _ referrals: [String], 
    _ sellers: [String], 
    _ amounts: [Int]
) -> [Int] {
    let indexDict: [String: Int] = { 
        var indexDict = [String: Int]()
        for index in 0..<enrolls.count {
            indexDict[enrolls[index]] = index
        }
        return indexDict
    }()
    
    let parents: [Int] = {
        var parents = [Int](repeating: -1, 
                            count: enrolls.count)
        for index in 0..<enrolls.count {
            parents[index] = indexDict[referrals[index], default: -1]
        }
        return parents
    }()
    
    var totalAmounts = [Int](repeating: 0, count: enrolls.count)
    
    func receive(index: Int, amount: Int) {
        guard index >= 0, amount > 0 else { return }
        
        let divisionAmount = amount / 10
        let realAmount = amount - divisionAmount
        totalAmounts[index] += realAmount
        receive(index: parents[index], amount: divisionAmount)
    }
    
    for i in 0..<sellers.count {
        guard let sellerIndex = indexDict[sellers[i]] else { 
            break 
        }
        let amount = amounts[i] * 100
        receive(index: sellerIndex, amount: amount)
    }
    
    return totalAmounts
}