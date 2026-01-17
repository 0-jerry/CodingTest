
func solution(_ number:String, _ k:Int) -> String {
    let numbers = number.compactMap{ $0.wholeNumberValue }

    var sub: [Int] = []

    var k = k

    for (i,e) in numbers.enumerated() {
        while k>0, sub.isEmpty == false, sub.last! < e {
            k-=1
            sub.removeLast()
        }

        if k == 0 {
            sub.append(contentsOf: numbers[i...])
            break
        } else {
            sub.append(e)
        }
    }

    return sub[..<(sub.count-k)].map {String($0)}.joined()
}