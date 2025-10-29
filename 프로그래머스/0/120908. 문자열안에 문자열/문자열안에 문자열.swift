import Foundation

func solution(_ str1:String, _ str2:String) -> Int {
    let length = str2.count
    var str = str1
    
    while str.count >= length {
        if str.hasSuffix(str2) {
            return 1
        } else {
            str.removeLast()
        }
    }
    
    return 2
}