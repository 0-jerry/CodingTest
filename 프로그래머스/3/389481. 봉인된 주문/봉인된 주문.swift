import Foundation

func solution(_ n: Int64, _ bans: [String]) -> String {
    var n = Int(n)
    
    func letterToNumber(_ lowercase: Character) -> Int {
        let scalar = lowercase.unicodeScalars.first!
        let value = Int(scalar.value)
        return value - 96
    }
    
    func numberToLetter(_ num: Int) -> Character {
        return Character(UnicodeScalar(num + 96)!)
    }

    func spellToIndex(_ spell: String) -> Int {
        var index = 0
        var mul = 1 
        let array = Array<Character>(spell)
        let length = array.count
        for i in 1...array.count {
            let converted = letterToNumber(array[length-i])
            index += converted * mul
            mul *= 26
        }
        
        return index 
    }
    
    func indexToSpell(_ num: Int) -> String {
        var n = num
        var numbers = [Int]()
        while n > 0 {
            if n % 26 == 0 {
                numbers.append(26)
                n /= 26 
                n -= 1
            } else {
                numbers.append(n % 26)
                n /= 26
            }
        }
        
        var spell = ""
        let numbersCount = numbers.count
        for i in 1...numbers.count {
            spell.append(numberToLetter(numbers[numbersCount-i]))
        }
        return spell
    }
    
    let sortedBans = bans.sorted {
        if $0.count == $1.count { 
            return $0 < $1 
        } else {
            return $0.count < $1.count
        }
    }
    
    for banedSpell in sortedBans {
        let raw = spellToIndex(banedSpell)
        if raw <= n {
            n += 1
        } else { break }
    }    
    
    return indexToSpell(n)
}