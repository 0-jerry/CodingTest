import Foundation
/*
0/1 문자열
0 / 111111 / 010
0 / 110 / 1111 / 10
0 / 110 / 110 / 111


1이 3개 이상 연속되며, 그 이후에 0이 존재하는 경우, 
110 으로 변형해 앞 시퀀스로 이동하는 형태 반복

Stack 을 통해 이어간다.

1. 완료 시퀀스 
2. 연속 1 담기 stack ? -> 그냥 카운트면 됨
순행하며

순행 흐름
0인 경우,
    -> count(Stack) >= 3,
        -> count -= 2; 
           완료 시퀀스 += "110"

    -> count(Stack) < 3,
        -> (count 만큼) 완료 시퀀스 += 1;
            0을 마지막에 추가;

1인 경우,
    -> count(Stack) += 1
    
순행이 끝난 뒤, (count 만큼) 완료 시퀀스 += 1

0이 반복되는 경우?

--- 0이 연속되는 경우를 간과함


110 은 앞의 111에 대해서,
뒤의 110 보다 작은 경우에 대해서, 이동해야함 또한 이 경우는 110보다 큰 수의 바로 앞으로 이동 "0" 10" 에 대해서 뒤로 이동해야함, 하지만 111이상의 수가 나오면 초기화




111의 앞으로, 110 > 에 대해선 뒤로

*/
func solution(_ s: [String]) -> [String] {
    
    func remake(_ str: String) -> String {
        var remaked = ""
        var countOne = 0
        var countSeven = 0
        for char in str {
            if char == "0" {
                if countOne >= 2 {
                    countOne -= 2
                    countSeven += 1
                } else {
                    while countOne > 0 {
                        remaked += "1"
                        countOne -= 1
                    }
                    remaked += "0"
                }
            } else {
                countOne += 1 
            }
        }
        
        while countSeven > 0 {
            remaked += "110"
            countSeven -= 1
        }
        
        while countOne > 0 {
            remaked += "1"
            countOne -= 1
        }
        
        
        
        return remaked
    }
    
    return s.map { remake($0) }
}