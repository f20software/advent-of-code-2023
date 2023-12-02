//
//  main.swift
//  Day01
//
//  Created by Vladimir Svidersky on 12/2/23.
//

import Foundation

let digits: [String: Int] = [
    "one": 1,
    "1": 1,
    "two": 2,
    "2": 2,
    "three": 3,
    "3": 3,
    "four": 4,
    "4": 4,
    "five": 5,
    "5": 5,
    "six": 6,
    "6": 6,
    "seven": 7,
    "7": 7,
    "eight": 8,
    "8": 8,
    "nine": 9,
    "9": 9,
    "zero": 0,
    "0": 0
]


func processLine(line: String) -> Int {
    var temp = line
    var found = false
    var first = -1
    var last = -1
    
    while found == false {
        digits.forEach { (key: String, value: Int) in
            if temp.hasPrefix(key) {
                found = true
                first = value
                return
            }
        }
        temp.removeFirst()
    }

    found = false
    temp = line
    while found == false {
        digits.forEach { (key: String, value: Int) in
            if temp.hasSuffix(key) {
                found = true
                last = value
                return
            }
        }
        temp.removeLast()
    }

    return first * 10 + last
}

// Test data
var res0 = 0
data00.forEach { line in
    res0 = res0 + processLine(line: line)
}
print("Result is \(res0)")


var res1 = 0
data1.forEach { line in
    res1 = res1 + processLine(line: line)
}
print("Result is \(res1)")
