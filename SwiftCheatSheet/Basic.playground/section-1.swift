//String, Character, Int, Double
//开头字母皆为大写


//Ternary Conditional Operator
var z = (1 == 2 ? "1 equal 2" : "1 not equal 2")


//Nil Coalescing Operator
let defaultColorName = "red"
var userDefinedColorName: String?   // defaults to nil
var colorNameToUse = userDefinedColorName ?? defaultColorName  //since userDefinedColorName is nil, so the colorNameToUse will be assigned by the second variable.
userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName

//Closed Range Operator
//include 1 and 5
let end = 5
let beg = 1
for index in beg...end {
    println("\(index) times 5 is \(index * 5)")
}

//Half-Open Range Operator
let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    println("Person \(i + 1) is called \(names[i])")
}




//string equal
let x = "hello"
let y = "swift"
let isEqual = (x == y)


//string append by simply using "+"
z = x + " " + y


//A value type is a type whose value is copied when it is assigned to a variable or constant, or when it is passed to a function.
//integers, floating-point numbers, Booleans, strings, arrays and dictionaries—are value types
//All structures and enumerations are value types
//Behind the scenes, Swift’s compiler optimizes string usage so that actual copying takes place only when absolutely necessary. This means you always get great performance when working with strings as value types.
//Classes Are Reference Types



//Unicode
let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
let globe = "🌍aaass"     // U+1F30D EARTH GLOBE EUROPE-AFRICA
countElements(globe) // -> 1


//Tuples
let http404Error = (404, "Not Found")
println("The status code is \(http404Error.0)") // prints "The status code is 404"
println("The status message is \(http404Error.1)") // prints "The status message is Not Found"

let http200Status = (statusCode: 200, description: "OK")
println("The status code is \(http200Status.statusCode)")  // prints "The status code is 200"
println("The status message is \(http200Status.description)") // prints "The status message is OK"


//Functions with Multiple Return Values
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}



//Optional Binding
//if let or if var
var possibleNumber = "112a"
if var actualNumber = possibleNumber.toInt() {
    println("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
} else {
    println("\'\(possibleNumber)\' could not be converted to an integer")
}


//Implicitly Unwrapped Optionals
//Sometimes it is clear from a program’s structure that an optional will always have a value, after that value is first set. In these cases, it is useful to remove the need to check and unwrap the optional’s value every time it is accessed, because it can be safely assumed to have a value all of the time.
//Implicitly Unwrapped Optionals： 有可能是nil，但可能性非常低。如果是话，程序也只有崩溃这条路可选，接着进行也没必要。
//放在要要access的variable名后面
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation mark

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // no need for an exclamation mark


//Assert
let age = -3
assert(age < 0, "A person's age cannot be less than zero")



