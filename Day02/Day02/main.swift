//
//  main.swift
//  Day02
//
//  Created by Vladimir Svidersky on 12/2/23.
//

import Foundation

func parseGame(line: String) -> (red: Int, green: Int, blue: Int) {
    var red = -1
    var blue = -1
    var green = -1
    
    let pairs = line.split(separator: ",")
    pairs.forEach { pair in
        let p = pair.trimmingCharacters(in: CharacterSet.whitespaces)
        let d = p.split(separator: " ")
        if d[1] == "red" {
            red = Int(d[0])!
        } else if d[1] == "green" {
            green = Int(d[0])!
        } else if d[1] == "blue" {
            blue = Int(d[0])!
        }
    }
    
    return (red: red, green: green, blue: blue)
}

func parseLine(line: String) -> (gameId: Int, games: [String]) {
    let pair = line.split(separator: ":")
    var gameId = 0
    
    
    let gameIdPair = pair[0].split(separator: " ")
    gameId = Int(gameIdPair[1])!
    
    let games = pair[1].components(separatedBy: ";")
    return (gameId: gameId, games: games)
}

let maxRed = 12
let maxGreen = 13
let maxBlue = 14

func processLine(line: String) -> Int {
    let (id, games) = parseLine(line: line)
    var good = true
    
    games.forEach { game in
        let (red, green, blue) = parseGame(line: game)
        if red > maxRed || green > maxGreen || blue > maxBlue {
            good = false
            return
        }
    }

    if good {
        return id
    } else {
        print("IMPOSSIBLE: \(line)")
        return 0
    }
}

func findPower(line: String) -> Int {
    let (_, games) = parseLine(line: line)
    
    var minRed = 0
    var minGreen = 0
    var minBlue = 0
    
    games.forEach { game in
        let (red, green, blue) = parseGame(line: game)
        if red > 0 && red > minRed {
            minRed = red
        }
        if blue > 0 && blue > minBlue {
            minBlue = blue
        }
        if green > 0 && green > minGreen {
            minGreen = green
        }
    }
    
    print("POWER: \(minRed * minBlue * minGreen), LINE: \(line)")
    return minRed * minBlue * minGreen
}

// PART 1

// Test data
var res0 = 0
data0.forEach { line in
    res0 = res0 + processLine(line: line)
}
print("Result is \(res0)")

// Real data
var res1 = 0
data1.forEach { line in
    res1 = res1 + processLine(line: line)
}

print("Result is \(res1)")

// PART 2

// Test data
var res20 = 0
data0.forEach { line in
    res20 = res20 + findPower(line: line)
}
print("Result is \(res20)")

// Real data
var res21 = 0
data1.forEach { line in
    res21 = res21 + findPower(line: line)
}

print("Result is \(res21)")
