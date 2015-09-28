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






