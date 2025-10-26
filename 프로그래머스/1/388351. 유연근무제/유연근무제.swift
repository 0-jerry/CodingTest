import Foundation
/*
문제 해석
0. 일주일 간 출근시간을 잘 지킨 직원들에게 상품을 주는 이벤트 진행 
1. 출근 희망 시각 + 10 분 까지 출근
    1-1. 단 토 일 은 이벤트에 참여 X 
    1-2. 매일 한번씩만 출근, HH * 100 + mm 형태로 표현

2. 상품을 받을 직원 수
    2-1. schedules = 출근 희망 시각을 담은 1차원 정수 배열
    2-2. timelogs = [일주일 출근 시간] 을 담은 2차원 정수 배열
    2-3. startday = 시작 요일을 담은 정수 월=1 / 일 = 7
*/
func solution(_ schedules:[Int], _ timelogs:[[Int]], _ startday:Int) -> Int {
    
    let indices: [Int] = {
        var indices: [Int] = []
        for i in 0...6 {
             let value = (i + startday) % 7
            if  (1...5).contains(value) {
                indices.append(i)
            }
        }
        return indices
    }()
    
    var count = 0 
    
    func lastTime(_ schedule: Int) -> Int {
        var hour = schedule / 100 
        var minute = schedule % 100 + 10
        if minute >= 60 {
            minute -= 60
            hour += 1
        }
        return hour * 100 + minute
    }
    
    for i in 0..<schedules.count {
        var flag = true
        let timelog = timelogs[i]
        let schedule = lastTime(schedules[i])
        for index in indices {
            guard timelog[index] <= schedule else {
                flag = false
                break
            }
        }
        if flag { count += 1 }
    }
    
    return count
}