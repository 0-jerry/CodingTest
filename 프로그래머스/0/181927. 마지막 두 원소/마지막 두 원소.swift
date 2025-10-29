import Foundation

func solution(_ numList:[Int]) -> [Int] {
    let numCount = numList.count
    let last = numList[numCount-2] < numList[numCount-1] ? numList[numCount-1] - numList[numCount-2] : numList[numCount-1] * 2 
    
    return numList + [last]
}