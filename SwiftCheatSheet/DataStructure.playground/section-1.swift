// Playground - noun: a place where people can play

import UIKit


//If you create an array of Int values, for example, you can’t insert any value other than Int values into that array. Swift arrays are type safe, and are always clear about what they may contain
//不同于obj-c的nsarray，只能放一种类型。同时，swift list是mutable
var shoppingList = ["Eggs", "Milk"]
shoppingList.append("Flour")
shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
shoppingList[4...6] = ["Bananas", "Apples"]
println(shoppingList)
shoppingList.insert("Maple Syrup", atIndex: 0)

//for each loop with index and value
for (index, value) in enumerate(shoppingList) {
    println("Item \(index + 1): \(value)")
}


//list with repeated value
var threeDoubles = [Double](count: 3, repeatedValue: 0.0)
var anotherThreeDoubles = [Double](count: 3, repeatedValue: 2.5)
//list append
var sixDoubles = threeDoubles + anotherThreeDoubles




//Dictionary
//use hash internal. so the object need to hashable
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
airports["LHR"] = "London"
airports["LHR"] = "London Heathrow"
// the value for "LHR" has been changed to "London Heathrow"
airports["LHR"] = nil
for (airportCode, airportName) in airports {
    println("\(airportCode): \(airportName)")
}


var namesOfIntegers = [Int: String]()
// namesOfIntegers is an empty [Int: String] dictionary
namesOfIntegers[16] = "sixteen"
// namesOfIntegers now contains 1 key-value pair
namesOfIntegers = [:]
// namesOfIntegers is once again an empty dictionary of type [Int: String]
if let temp = airports["apple"]
{
    println("there is \(temp)")
}else
{
    println("no apple")
}




