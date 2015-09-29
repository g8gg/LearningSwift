//: Playground - noun: a place where people can play

import Cocoa

/**
*  闭包 Closures
闭包是自包含的函数代码块,可以在代码中被传递和使用。
Swift 中的闭包与 C 和 Objective-C 中的代码块(blocks)以及其他一些编程语言中的匿名函数比较相似。
闭包可以捕获和存储其所在上下文中任意常量和变量的引用。 这就是所谓的闭合并包裹着这些常量和变量,俗称 闭包。Swift 会为您管理在捕获过程中涉及到的所有内存操作。
*/
//在函数中介绍的全局和嵌套函数实际上也是特殊的闭包,闭包采取如下三种形式之一:
//  全局函数是一个有名字但不会捕获任何值的闭包
//  嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
//  闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包

//Swift 的闭包表达式拥有简洁的风格,并鼓励在常见场景中进行语法优化,主要优化如下:
//  利用上下文推断参数和返回值类型
//  隐式返回单表达式闭包,即单表达式闭包可以省略 return 关键字
//  参数名称缩写
//  尾随(Trailing)闭包语法



//闭包表达式(Closure Expressions)
//嵌套函数 是一个在较复杂函数中方便进行命名和定义自包含代码模块的方式

//下面的闭包表达式示例使用 sort(_:) 方法对一个String类型的数组进行字母逆序排序
//该例子对一个 String 类型的数组进行排序,因此排序闭包函数类型需为 (String, String) -> Bool
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2//这是一个相当冗长的方式,本质上只是写了一个单表达式函数 (a > b)
}
var reversed = names.sort(backwards)


//闭包表达式语法(Closure Expression Syntax)
//{ (parameters) -> returnType in statements}
//闭包表达式语法可以使用常量、变量和 inout 类型作为参数,不提供默认值。 也可以在参数列表的最后使用可变 参数。 元组也可以作为参数和返回值。
reversed = names.sort({ (s1: String, s2: String) -> Bool in return s1 < s2})
//在内联闭包表达式中,函数和返回值类型都写在大括号内,而不是大括号外
//闭包的函数体部分由关键字 in 引入。 该关键字表示闭包的参数和返回值类型定义已经完成,闭包函数体即将开 始。
print(reversed)



//根据上下文推断类型(Inferring Type From Context)
//因为排序闭包函数是作为 sort(_:) 方法的参数进行传入的,Swift可以推断其参数和返回值的类型。
//sorted 期望第二个参数是类型为 (String, String) -> Bool 的函数,因此实际上￼￼String,String和Bool类型并不需要作为闭包表达式定义中的一部分。 因为所有的类型都可以被正确推断,返回箭头 ( -> ) 和围绕在参数周围的括号也可以被省略:
reversed = names.sort( { s1, s2 in return s1 > s2 } )
print(reversed)
//实际上任何情况下,通过内联闭包表达式构造的闭包作为参数传递给函数时,都可以推断出闭包的参数和返回值类型,这意味着您几乎不需要利用完整格式构造任何内联闭包。






/**
*  单表达式闭包隐式返回(Implicit Return From Single-Expression Clossures)
单行表达式闭包可以通过隐藏 return 关键字来隐式返回单行表达式的结果,如上版本的例子可以改写为:
*/
reversed = names.sort( { s1, s2 in s1 < s2 } )
print(reversed)


/**
*  参数名称缩写(Shorthand Argument Names)
Swift 自动为内联函数提供了参数名称缩写功能,您可以直接通过$0,$1,$2来顺序调用闭包的参数
*/
//如果您在闭包表达式中使用参数名称缩写,您可以在闭包参数列表中省略对其的定义,并且对应参数名称缩写的 类型会通过函数类型进行推断。 in 关键字也同样可以被省略,因为此时闭包表达式完全由闭包函数体构成:
reversed = names.sort( { $0 > $1 } )
print(reversed)
//在这个例子中, $0 和 $1 表示闭包中第一个和第二个 String 类型的参数。





/**
*  运算符函数(Operator Functions)
*/
//实际上还有一种更简短的方式来撰写上面例子中的闭包表达式。
// Swift 的 String 类型定义了关于大于号 ( > ) 的 字符串实现,其作为一个函数接受两个 String 类型的参数并返回 Bool 类型的值。 而这正好与 sort(_:) 方法的 第二个参数需要的函数类型相符合。 因此,您可以简单地传递一个大于号,Swift可以自动推断出您想使用大于号 的字符串函数实现:
reversed = names.sort(<)





/**
*  尾随闭包(Trailing Closures)
如果您需要将一个很长的闭包表达式作为最后一个参数传递给函数,可以使用尾随闭包来增强函数的可读性。 尾 随闭包是一个书写在函数括号之后的闭包表达式,函数支持将其作为最后一个参数调用
*/
func someFunctionThatTakesAClosure(closure: () -> Void) { // 函数体部分
}
// 以下是不使用尾随闭包进行函数调用 
someFunctionThatTakesAClosure({
// 闭包主体部分 
})
// 以下是使用尾随闭包进行函数调用 
someFunctionThatTakesAClosure() {
// 闭包主体部分 
}
//注意: 如果函数只需要闭包表达式一个参数,当您使用尾随闭包时,您甚至可以把 () 省略掉。
reversed = names.sort{ $0 > $1 } // 等于reversed = names.sort(){ $0 > $1 }
print(reversed)


let digitNames = [
    0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four", 5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]
let strings = numbers.map { (var number) -> String in
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}
print(strings)
//上例中尾随闭包语法在函数后整洁封装了具体的闭包功能,而不再需要将整个闭包包裹在函数的括号内


/**
*  捕获值(Capturing Values)
闭包可以在其定义的上下文中捕获常量或变量。 即使定义这些常量和变量的原域已经不存在,闭包仍然可以在闭 包函数体内引用和修改这些值。
*/
func makeIncrementor(forIncrement amount: Int) -> () -> Int{
    var runningTotal = 0
    //incrementer 函数并没有任何参数,但是在函数体内访问了 runningTotal 和 amount 变量
    //这是因为其通过捕 获在包含它的函数体内已经存在的 runningTotal 和 amount 变量的引用(reference)而实现
    func incrementor() -> Int {
        runningTotal += amount
        return runningTotal
        }
    return incrementor
}
//注意: 为了优化,Swift可能会捕捉和保存一份对值的拷贝,如果这个值是不可变或是在闭包外的。 Swift同样负责 被捕捉的所有变量的内存管理,包括释放不被需要的变量。

let incrementByTen = makeIncrementor(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()
let incrementBySeven = makeIncrementor(forIncrement: 7)
incrementBySeven()
incrementBySeven()
incrementBySeven()
// incrementBySevne 捕获了一个新的 runningTotal 变量,该变量和 incrementByTen 中捕获的变量没有任 何联系
//注意: 如果您将闭包赋值给一个类实例的属性,并且该闭包通过指向该实例或其成员来捕获了该实例,您将创 建一个在闭包和实例间的强引用环。 Swift 使用捕获列表来打破这种强引用环。


/**
*  闭包是引用类型(Closures Are Reference Types)
*/
//无论您将函数/闭包赋值给一个常量还是变量,您实际上都是将常量/变量的值设置为对应函数/闭包的引用。
//这也意味着如果您将闭包赋值给了两个不同的常量/变量,两个值都会指向同一个闭包
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen() //刚才已经30了




