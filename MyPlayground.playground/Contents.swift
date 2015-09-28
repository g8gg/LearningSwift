//: Playground - noun: a place where people can play
// Learning 《The Swift 2 Programming》

import Cocoa

var x = 0.0, y = 0.0, z = 0.0
var red, green, blue: Double
var welcomeMessage: String

welcomeMessage="你好"
/*  let languageName = "Swift"
    languageName = "Swift++"
    // 这会报编译时错误 - languageName 不可改变
*/
welcomeMessage.appendContentsOf("，Swift 2");print(welcomeMessage)
let maxValue = UInt8.max
let minValue = UInt8.min
//var maxxValue= UInt8.max
print(minValue,maxValue)

//Type Safe
let meaningOfLife = 42
// meaningOfLife 会被推测为 Int 类型
let anotherPi = 3 + 0.14159
// anotherPi 会被推测为 Double 类型
let decimalInteger = 17
let binaryInteger = 0b10001 // 二进制的17
let octalInteger = 0o21 // 八进制的17
let hexadecimalInteger = 0x11 // 十六进制的17

let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1

/*
let cannotBeNegative: UInt8 = -1
//UInt8 类型不能存储负数,所以会报错
let tooBig: Int8 = Int8.max + 1
// Int8 类型不能存储超过最大值的数,所以会报错
*/

let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
//let twoThousandAndOne = twoThousand + one
//要将一种数字类型转换成另一种,你要用当前值来初始化一个期望类型的新数字,这个数字的类型就是你的目标类型
let twoThousandAndOne = twoThousand + UInt16(one)
//目标常量的类型被推断为UInt16,因为它是两个UInt16值的和

//整数和浮点数的转换必须显式指定类型
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine // pi 等于 3.14159,所以被推测为 Double 类型
let integerPi = Int(pi)
//integerPi 等于 3,所以被推测为 Int 类型

//结合数字类常量和变量不同于结合数字类字面量
//字面量 3 可以直接和字面量 0.14159 相加,因为数字字面量本身没有明确的类型，它们的类型只在编译器需要求值的时候被推测
/*注意:
    结合数字类常量和变量不同于结合数字类字面量。字面量 3 可以直接和字面量 0.14159 相加,因为数字字面量本身没有明确的类型。
    它们的类型只在编译器需要求值的时候被推测
*/
typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min // maxAmplitudeFound 现在是 0

let orangesAreOrange = true
let turnipsAreDelicious = false

if turnipsAreDelicious { print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible.")
}

//tuples
let http404Error = (404, "Not Found")
//内容分解decompose
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
print("The status message is \(statusMessage)")
//忽略的部分用_标记
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")
//下标
print("The status code is \(http404Error.0)")
print("The status message is \(http404Error.1)")
//直接命名
let http200Status = (statusCode: 200, description: "OK")
print("The status code is \(http200Status.statusCode)")
print("The status message is \(http200Status.description)")
/*
注意:
    元组在临时组织值的时候很有用,但是并不适合创建复杂的数据结构。如果你的数据结构并不是临时使用,请使
用类或者结构体而不是元组。
*/


//可选类型optionals

var serverResponseCode: Int? = 404 // serverResponseCode 包含一个可选的 Int 值 404
serverResponseCode = nil // serverResponseCode 现在不包含值
//var serverRepCoe: Int = 404
//serverRepCoe = nil
/*
注意:
    nil不能用于非可选的常量和变量。如果你的代码中有常量或者变量需要处理值缺失的情况,请把它们声明成对
应的可选类型
*/
var surveyAnswer: String? // surveyAnswer 被自动设置为 nil
/*
注意:
    Swift 的 nil 和 Objective-C 中的 nil 并不一样。在 Objective-C 中, nil 是一个指向不存在对象的指针。
在 Swift 中, nil 不是指针——它是一个确定的值,用来表示值缺失。任何类型的可选状态都可以被设置为 nil ,不只是对象类型。
*/

var  convertedNumber: Int? = 100
if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
}

let possibleNumber = "123a"
if let actualNumber = Int(possibleNumber) {
    print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
} else {
    print("\'\(possibleNumber)\' could not be converted to an integer")
}

//implicitly optional
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 需要惊叹号来获取值
let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // 不需要感叹号

if(assumedString != nil ) {
    print(implicitString)
}
if let definiteString = assumedString {
    print(definiteString)
}
/*
注意:
    如果一个变量之后可能变成 nil 的话请不要使用隐式解析可选类型。如果你需要在变量的生命周期中判断是否是
nil 的话,请使用普通可选类型。
*/


//错误处理 error handling
func canThrowAnErrow() throws { // 这个函数有可能抛出错误
}

do {
    try canThrowAnErrow() // 没有错误消息抛出
} catch {
    // 有一个错误消息抛出
}

/*
let age = -1
assert(age>0,"Age must be above zero.")
*/








