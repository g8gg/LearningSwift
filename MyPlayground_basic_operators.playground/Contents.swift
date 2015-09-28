//: Playground - noun: a place where people can play

import Cocoa

var pi = 3.1415926
var mod_by_float = pi % 3 //对浮点数取模

/* 等号(＝)不再返回值，避免判断运算符导致(==)写错的错误
if (pi = 3.14) {
    print("error")
}*/

var i=0
print(i++)
print(++i)
print(i--)
print(--i)

//三元运算符 ternary
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20) // rowHeight 现在是 90

//空合运算符 
var a:String?="a"
var a1:String?
var b:String="b"
a != nil ? a! : b
a1 != nil ? a1! : b
/*
注意: 如果 a 为非空值( non-nil ),那么值 b 将不会被估值。这也就是所谓的短路求值
*/

let defaultColorName = "red"
var userDefinedColorName: String? //默认值为 nil
var colorNameToUse = userDefinedColorName ?? defaultColorName


//区间运算符 a...b，半开区间a..<b
for index in 1...5 {
    print("\(index) * 5 = \(index * 5)")
}

let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("第 \(i + 1) 个人叫 \(names[i])")
}



