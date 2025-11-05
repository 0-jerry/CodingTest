import Foundation

func solution(_ citations: [Int]) -> Int {
    var filtered = citations
    var hIndex = 0 
    while true {
        let filteredCitations = filtered.filter { $0 >= hIndex }
        
        if filteredCitations.count >= hIndex {
            hIndex += 1
            filtered = filteredCitations
        } else {
            return hIndex-1
        }
    }
    
    
    return -1
}