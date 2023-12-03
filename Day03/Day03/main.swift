//
//  main.swift
//  Day02
//
//  Created by Vladimir Svidersky on 12/2/23.
//

import Foundation

extension String {
    func substring(_ location: Int, _ length: Int? = nil) -> String {
      let start = min(max(0, location), self.count)
      let limitedLength = min(self.count - start, length ?? Int.max)
      let from = index(startIndex, offsetBy: start)
      let to = index(startIndex, offsetBy: start + limitedLength)
      return String(self[from..<to])
    }
}

class Number3 {
    let line: Int
    let pos: Int
    let length: Int
    let str: String
    
    init(line: Int, pos: Int, length: Int, str: String) {
        self.line = line
        self.pos = pos
        self.length = length
        self.str = str
    }
    
    func isAdjustent(to line: Int, pos: Int) -> Bool {
        return (line >= self.line-1 && line < self.line+2 &&
                pos >= self.pos-1 && pos <= self.pos+length)
    }
}

func findNumbers(lineIdx: Int, line: String) -> [Number3] {
    var start = 0
    var inside = false
    var length = 0
    var result: [Number3]  = []
    var lastNumberStart = -1
    
    line.forEach { c in
        if c.isNumber {
            if inside {
                length = length + 1
            } else {
                length = 1
                lastNumberStart = start
                inside = true
            }
        } else {
            if inside {
                result.append(
                    Number3(
                        line: lineIdx,
                        pos: lastNumberStart,
                        length: length,
                        str: line.substring(lastNumberStart, length)
                    )
                )
                inside = false
                length = 0
                lastNumberStart = -1
            } else {
                
            }
        }
        start = start + 1
    }
    if inside {
        result.append(
            Number3(
                line: lineIdx,
                pos: lastNumberStart,
                length: length,
                str: line.substring(lastNumberStart, length)
            )
        )
    }

    return result
}

func isPartNumber(data: [String], number: Number3) -> Bool {
    for x in (number.pos-1...number.pos+number.length) {
        if x >= 0 && x < data[0].count {
            let xi = data[number.line].index(data[number.line].startIndex, offsetBy: x)
            if number.line > 0 && data[number.line-1][xi] != "." {
                return true
            }
            if number.line < data.count-1 && data[number.line+1][xi] != "." {
                return true
            }
        }
    }
    
    if number.pos > 0 {
        let xi = data[number.line].index(data[number.line].startIndex, offsetBy: number.pos-1)
        if data[number.line][xi] != "." {
            return true
        }
    }
    if number.pos+number.length < data[number.line].count-1 {
        let xi = data[number.line].index(data[number.line].startIndex, offsetBy: number.pos+number.length)
        if data[number.line][xi] != "." {
            return true
        }
    }

    return false
}



// Part 1
var index = 0
var result = 0
let data = data1
data.forEach { line in
    let numbers = findNumbers(lineIdx: index, line: line)
    
    numbers.forEach { num in
        if isPartNumber(data: data, number: num) {
            result = result + Int(num.str)!
        }
    }
    index = index + 1
}

print("Result part 1 is \(result)")

// Part 2
var prev: [Number3] = []
var current: [Number3] = []
var next: [Number3] = []
result = 0

for i in 0..<data.count {
    prev = current
    current = next.isEmpty ? findNumbers(lineIdx: i, line: data[i]) : next
    next = (i == data.count-1) ? [] : findNumbers(lineIdx: i+1, line: data[i+1])
    
    for x in 0..<data[i].count {
        if data[i].substring(x, 1) == "*" {
            var allNumbers = prev
            allNumbers.append(contentsOf: current)
            allNumbers.append(contentsOf: next)
            
            let adj = allNumbers.filter { $0.isAdjustent(to: i, pos: x) }
            if adj.count == 2 {
                result = result + (Int(adj[0].str)! * Int(adj[1].str)!)
            }
        }
    }
}
print("Result part 2 is \(result)")

