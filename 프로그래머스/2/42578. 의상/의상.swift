import Foundation

func solution(_ clothes:[[String]]) -> Int {
    
    //옷 종류별 Set 형태로 저장
    var clothesDict: [String: Set<String>] = [:]
     
    for clothe in clothes {
        let clotheStyle = clothe[0]
        let clotheType = clothe[1]
        
        clothesDict[clotheType, default: []].insert(clotheStyle)
    }
    
    //곱연산을 위해 1로 초기화
    var countOfStyle = 1

    //옷 종류별 (count + 1) 곱한다 ( +1 : 입지 않은 경우 ) 
    clothesDict.values.forEach {
       countOfStyle *= ($0.count + 1)
    }
    
    //아무것도 입지 않은 경우 제외 
    countOfStyle -= 1
    
    return countOfStyle
}