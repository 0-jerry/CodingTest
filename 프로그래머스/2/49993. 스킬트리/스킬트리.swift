import Foundation

/*
자료구조
스킬을 순서에 맞춰 dictionary 로 저장
스킬을 set으로 저장해 포함되는지 확인

2중 for문

0. 스킬 순서 저장 = 0 (기본값)
1. skill - set을 통해 순서가 정해져있는지 확인
2. 순서가 정해진 스킬이라면 순서에 맞는지 확인
3. 순서에 맞지 않는다면 break
*/

func solution(_ skill: String, _ skill_trees:[String]) -> Int {
    var answer = 0
    
    let skillArr = Array(skill)
    var skillIndex = [Character: Int]()
    
    for i in skillArr.enumerated() {
        skillIndex[i.element] = i.offset
    }
    
    for skillTree in skill_trees {
        var currentIndex = 0
        var flag = true
        for i in skillTree {
            if let index = skillIndex[i] {
                if index == currentIndex {
                    currentIndex += 1
                } else {
                    flag = false
                    break
                }
            } 
        }
        answer += flag ? 1 : 0
    }
    
    return answer
}



