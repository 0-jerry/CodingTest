func solution(_ s: String) -> String {
    var intSet = Set<Int>()
    
    s.split(separator: " ").forEach {
        if let int = Int($0) {
            intSet.insert(int)
        }
    }
    
    return "\(intSet.min()!) \(intSet.max()!)"
}