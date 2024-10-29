import Foundation

func solution(_ s:String) -> [Int] {
    var answer: [Int] = []
    var s = s
    var sDictionary: [Character: Int] = [:]
    for n in 0 ..< s.count {

       let char: Character = s.first!
        s = String(s.dropFirst())
        if let postIndex = sDictionary[char] {
            answer.append(n-postIndex)
        } else { answer.append(-1) }
        sDictionary[char] = n
    }
    return answer
}
