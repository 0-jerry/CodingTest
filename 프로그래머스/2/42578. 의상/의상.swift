import Foundation

func solution(_ clothes: [[String]]) -> Int {
    var category = [String: Int]()
    
    for clothe in clothes {
        category[clothe[1], default: 1] += 1 
    }
    
    return category.values.reduce(1) { $0 * $1 } - 1
}