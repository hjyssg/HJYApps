// Playground - noun: a place where people can play

import UIKit


//To make the purpose of these String values clearer, define external parameter names for each join function parameter:
func join(string s1: String, toString s2: String, withJoiner joiner: String)
    -> String {
        return s1 + joiner + s2
}

var temp = join(string: "I ", toString: " need a job", withJoiner: "really")

//Function with Default Parameter Values
func join2(string s1: String, toString s2: String,
    withJoiner joiner: String = " ") -> String {
        return s1 + joiner + s2
}


//Shorthand External Parameter Names (#)
func containsCharacter(#string: String, #characterToFind: Character) -> [Int]
{
    var result = [Int]()
    let arr = Array(string)
    for (index, value) in enumerate(arr)
    {
        if value == characterToFind
        {
            result.append(index)
        }
    }
    return result
}
let index = containsCharacter(string: "apple", characterToFind: "p")



//!!!  parameters passed into function are constants by default.
/// unless put "var " before


// In-Out Parameters
func swapTwoInts(inout a: Int, inout b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
println("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// prints "someInt is now 107, and anotherInt is now 3"

// Function Types
// Using Function Types
func addTwoInts(a: Int, b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(a: Int, b: Int) -> Int {
    return a * b
}
var mathFunction: (Int, Int) -> Int = addTwoInts
let anotherMathFunction = addTwoInts
// anotherMathFunction is inferred to be of type (Int, Int) -> Int
