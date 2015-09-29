//: Playground - noun: a place where people can play

import Cocoa

/**
*  Functions
*/
//Swift 统一的函数语法足够灵活,可以用来表示任何函数,包括从最简单的没有参数名字的 C 风格函数,到复杂 的带局部和外部参数名的 Objective-C 风格函数。参数可以提供默认值,以简化函数调用。参数也可以既当做传 入参数,也当做传出参数,也就是说,一旦函数执行结束,传入的参数值可以被修改。
//在 Swift 中,每个函数都有一种类型,包括函数的参数值类型和返回值类型。你可以把函数类型当做任何其他普 通变量类型一样处理,这样就可以更简单地把函数当做别的函数的参数,也可以从其他函数中返回函数。函数的 定义可以写在在其他函数定义中,这样可以在嵌套函数范围内实现功能封装。


//函数的定义与调用(Defining and Calling Functions)
func sayHello(personName:String)->String{
    let greeting = "Hello, " + personName + "!"
    return greeting
}
print(sayHello("G8GG"))


//函数参数与返回值(Function Parameters and Return Values)

//多重输入参数(Multiple Input Parameters)
func halfOpenRangeLength(start: Int, end: Int) -> Int {
    return end - start
}
print(halfOpenRangeLength(1, end: 10))


//无参函数(Functions Without Parameters)
func sayHelloWorld() -> String {
    return "hello, world"
}
print(sayHelloWorld())

//多重返回值函数(Functions with Multiple Return Values)
//你可以用元组(tuple)类型让多个值作为一个复合值从函数中返回
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin { currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
let bounds = minMax([8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")

//可选元组返回类型(Optional Tuple Return Types)
func minMaxNew(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin { currentMin = value
    } else if value > currentMax {
            currentMax = value }
    }
    return (currentMin, currentMax)
}

if let bounds1 = minMaxNew([]) {
        print("min is \(bounds1.min) and max is \(bounds1.max)")
}
    else {
        print("nothing")
}


//函数参数名称(Function Parameter Names)
//函数参数都有一个外部参数名(external parameter name)和一个本地参数名(local parameter name).外部参 数名用来标记传递给函数调用的参数,本地参数名在实现函数的时候使用.


func someFunction(firstParameterName: Int, secondParameterName: Int) { // function body goes here
    // firstParameterName and secondParameterName refer to
    // the argument values for the first and second parameters
}
someFunction(1, secondParameterName: 2)

//指定外部参数名(Specifying External Parameter Names)
func someFunction(externalParameterName localParameterName: Int) { // function body goes here, and can use localParameterName
    // to refer to the argument value for that parameter
}

func sayHello2(to person: String, and anotherPerson: String) -> String {
    return "Hello \(person) and \(anotherPerson)!"
}
print(sayHello2(to: "G8GG", and: "Xue"))
/**
*  为每个参数指定外部参数名,在你调用函数 sayHello(to:and:) 函数时时两个参数都必须被标记出来. 使用外部函数名可以使得函数可以用一句话表达清楚,并且使得函数体内部可读,能表达出函数的明确意图.
*/






//忽略外部参数名(Omitting External Parameter Names)
//如果你不想为第二个及后续的参数设置参数名,用一个下划线(_)代替一个明确地参数名.
func someFunction(firstParameterName: Int, _ secondParameterName: Int) { // function body goes here
    // firstParameterName and secondParameterName refer to
    // the argument values for the first and second parameters
}
someFunction(1, 2)



//默认参数值(Default Parameter Values)
func someFunction(parameterWithDefault: Int = 12) { // function body goes here
    // if no arguments are passed to the function call, // value of parameterWithDefault is 42
    print(parameterWithDefault)
}
someFunction()



//可变参数(Variadic Parameters)
//一个 可变参数(variadic parameter) 可以接受零个或多个值。函数调用时,你可以用可变参数来传入不确定数量的输入参数。通过在变量类型名后面加入 (...) 的方式来定义可变参数。
func arithmeticMean(numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
arithmeticMean(3, 8.25, 18.75)
//注意: 最多可以有一个可变参数函数,和它必须出现在参数列表中,为了避免歧义在调用函数有多个参数。 如果 你的函数有一个或多个参数有默认值,还有一个可变的参数,将可变参写在参数列表的最后。

func testFunc(p1: Double = 0.1, p3:Double... , p2:Double)->Double{//不写在最后其实也没问题
    return p1
}
print(testFunc( p3: 1.2,2.3, p2: 12))



//常量参数和变量参数(Constant and Variable Parameters)
/**
*  函数参数默认是常量。试图在函数体中更改参数值将会导致编译错误。这意味着你不能错误地更改参数值。
但是,有时候,如果函数中有传入参数的变量值副本将是很有用的。你可以通过指定一个或多个参数为变量参
数,从而避免自己在函数中定义新的变量。变量参数不是常量,你可以在函数中把它当做新的可修改副本来使
用。

通过在参数名前加关键字 var 来定义变量参数*/
func alignRight(var string: String, totalLength: Int, pad: Character) -> String {
    let amountToPad = totalLength - string.characters.count
    if amountToPad < 1 {
        return string
    }
    let padString = String(pad)
    for _ in 1...amountToPad {
        string = padString + string
    }
    return string
}
let originalString = "hello"
let paddedString = alignRight(originalString, totalLength: 10, pad: "-")
print(originalString)
/**
*  注意: 对变量参数所进行的修改在函数调用结束后便消失了,并且对于函数体外是不可见的。变量参数仅仅存 在于函数调用的生命周期中。
*/



//输入输出参数(In-Out Parameters)
//1. 如果你想要一个函数可以修改参数的值,并且想要在这些修改在函数调用结束后仍然存在,那么就应该把这个参数定义为输入输出参数(In-Out Parameters)。
//2. 你只能将变量作为输入输出参数。你不能传入常量或者字面量(literal value),因为这些量是不能被修改的。
//3. 当传入的参数作为输入输出参数时,需要在参数前加 & 符,表示这个值可以被函数修改
//注意: 输入输出参数不能有默认值,而且可变参数不能用 inout 标记。如果你用 inout 标记一个参数,这个 参数不能被 var 或者 let 标记。

func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")



/**
*  函数类型(Function Types)
*/
//每个函数都有种特定的函数类型,由函数的参数类型和返回类型组成
func addTwoInts(a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(a: Int, _ b: Int) -> Int {
    return a * b
}
//这两个函数的类型是 (Int, Int) -> Int ,可以读作“这个函数类型,它有两个 Int 型的参数并返回一个 Int 型的 值。”

func printHelloWorld() {
    print("hello, world")
}
//这个函数的类型是: () -> void ,或者叫“没有参数,并返回 Void 类型的函数”。

/**
*  使用函数类型(Using Function Types)
*/
//在 Swift 中,使用函数类型就像使用其他类型一样。例如,你可以定义一个类型为函数的常量或变量,并将函数 赋值给它:
var mathFunction: (Int, Int) -> Int = addTwoInts
print("Result: \(addTwoInts(2,3))")
print("Result: \(mathFunction(2, 3))")

//有相同匹配类型的不同函数可以被赋值给同一个变量,就像非函数类型的变量一样:
mathFunction = multiplyTwoInts
print("Result: \(mathFunction(2, 3))")

//就像其他类型一样,当赋值一个函数给常量或变量时,你可以让 Swift 来推断其函数类型
let anotherMathFunction = addTwoInts
// anotherMathFunction is inferred to be of type (Int, Int) -> Int


/**
*  函数类型作为参数类型(Function Types as Parameter Types)
*/
//你可以用 (Int, Int) -> Int 这样的函数类型作为另一个函数的参数类型。这样你可以将函数的一部分实现交由给函 数的调用者。

func printMathResult(mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
//printMathResult(_:_:_:) 函数的作用就是输出另一个合适类型的数学函数的调用结果。它不关心传入函数是如 何实现的,它只关心这个传入的函数类型是正确的。这使得 printMathResult(_:_:_:) 可以以一种类型安全(typ e-safe)的方式来保证传入函数的调用是正确的。


/**
*  函数类型作为返回类型(Function Type as Return Types)
*/
//你可以用函数类型作为另一个函数的返回类型。你需要做的是在返回箭头( -> )后写一个完整的函数类型
func stepForward(input: Int) -> Int {
    return input + 1
}
func stepBackward(input: Int) -> Int {
    return input - 1
}
//下面这个叫做 chooseStepFunction(_:) 的函数,它的返回类型是 (Int) -> Int 的函数。
func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    return backwards ? stepBackward : stepForward
}
var currentValue = 3
let moveNearerToZero = chooseStepFunction(currentValue > 0)
print("Counting to zero:") // Counting to zero: 
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")

/**
*  嵌套函数(Nested Functions)
*/
//可以把函数定义在别 的函数体中,称作嵌套函数(nested functions)
//默认情况下,嵌套函数是对外界不可见的,但是可以被他们封闭函数(enclosing function)来调用
//一个封闭 函数也可以返回它的某一个嵌套函数,使得这个函数可以在其他域中被使用。
func chooseStepFunctionNew(backwards: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int {
        return input + 1
    }
    func stepBackward(input: Int) -> Int {
        return input - 1
    }
    return backwards ? stepBackward : stepForward
}
currentValue = -4
let moveNearerToZeroNew = chooseStepFunctionNew(currentValue > 0)
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZeroNew(currentValue)
}
print("zero!")











