import Foundation
/*
방금 그 곡 서비스 
1. 한 음악을 반복해서 재생할 때도 있어, 네오가 기억하는 멜로디는
음악의 끝 ~ 처음 부분으로 이어진 형태인 경우도 존재

2. 한 음악을 중간에 끊을 경우, 원본 음악에는 네오가 기억한 멜로디여도, 
네오가 들은 음악이 아닌 경우도 존재

-> 네오는 멜로디를 재생 시간과 제공된 악보를 직접 보면서 비교 

"C, C#, D, D#, E, F, F#, G, G#, A, A#, B"
*/
func solution(_ m: String, _ musicinfos: [String]) -> String {
    
    typealias Melody = [String]
    
    struct MusicInfo {
        let name: String 
        let melody: Melody
        let length: Int 

        func contains(_ other: Melody) -> Bool {
            var melodyStackCount = 0
            let melodyCount = melody.count 
            let otherCount = other.count
            
            for index in 0..<length {
                let current = melody[index % melodyCount]
                if other[melodyStackCount] != current { melodyStackCount = 0 }
                if other[melodyStackCount] == current { melodyStackCount += 1 }
                
                guard melodyStackCount != otherCount else { break }
            }
            return melodyStackCount == otherCount
        }
    }
    
    func toMelody(_ strMelody: String) -> Melody {
        var melody = Melody()
        var sound: String = ""
        
        for char in strMelody {
            if char != "#" && !sound.isEmpty {
                melody.append(sound)
                sound = ""
            } 
            sound.append(char)
        }
        
        if !sound.isEmpty {
            melody.append(sound)
        }
        
        return melody
    }
    
    func toMinute(_ time: String) -> Int {
        let maximum = 24 * 60 - 1
        let splited = time
                        .split(separator: ":")
                        .compactMap { Int($0) }
        
        return min((splited[0] * 60 + splited[1]), maximum)
    }
    
    let remember: Melody = toMelody(m)

    let sortedMusicInfos: [MusicInfo] = musicinfos
    .compactMap { musicInfo in
        let components = musicInfo.components(separatedBy: ",")
        guard components.count == 4 else { return nil }
        let startTime = toMinute(components[0])
        var endTime = toMinute(components[1])
        if endTime < startTime {
            endTime = 24 * 60 - 1
        }
        let length = endTime - startTime
        guard length >= remember.count else { return nil }
        
        let name = components[2]
        let melody = toMelody(components[3])
        
        return MusicInfo(
            name: name, 
            melody: melody, 
            length: length
        )
    }
    .sorted { $0.length > $1.length }
    
    
    for musicInfo in sortedMusicInfos {
        guard musicInfo.contains(remember) else { continue }
        return musicInfo.name 
    }

    return "(None)"
}