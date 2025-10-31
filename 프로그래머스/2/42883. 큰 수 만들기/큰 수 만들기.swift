import Foundation

func solution(_ number:String, _ k:Int) -> String {
    let size = number.count - k
    var count = k
    var stack: [String] = []

    number.forEach { element in
        while true {
            guard
                let peek = stack.last,
                peek < element.description else { break }

            if count == 0 { break }
            count -= 1

            _ = stack.popLast()
        }
        stack.append(element.description)
    }

    return stack.joined()[0 ..< size]
}

extension String {
    subscript (r: Range<Int>) -> String {
        let start = self.index(self.startIndex, offsetBy: r.lowerBound)
        let end = self.index(self.startIndex, offsetBy: r.upperBound)

        return String(self[start ..< end])
    }
}
