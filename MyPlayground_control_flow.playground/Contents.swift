//: Playground - noun: a place where people can play

import Cocoa

//控制流
/*
Swift提供了类似 C 语言的流程控制结构,包括可以多次执行任务的 for 和 while 循环,基于特定条件选择执行不同代码分支的 if 、 guard 和 switch 语句,还有控制流程跳转到其他代码的 break 和 continue 语句。
除了 C 语言里面传统的 for 循环,Swift 还增加了 for-in 循环,用来更简单地遍历数组(array),字典(dictio nary),区间(range),字符串(string)和其他序列类型。
Swift 的 switch 语句比 C 语言中更加强大。在 C 语言中,如果某个 case 不小心漏写了 break ,这个 case 就 会贯穿至下一个 case,Swift 无需写 break ,所以不会发生这种贯穿的情况。case 还可以匹配更多的类型模 式,包括区间匹配(range matching),元组(tuple)和特定类型的描述。 switch 的 case 语句中匹配的值可 以是由 case 体内部临时的常量或者变量决定,也可以由 where 分句描述更复杂的匹配条件。
*/

// For-In
for index in 1...5 {//index 是一个每次循环遍历开始时被自动赋值的常量
    print("\(index) times 5 is \(index * 5)")
}

let base = 3
let power = 10
var answer = 1
for _ in 1...power {//下划线符号 _ (替代循环中的变量)能够忽略具体的值,并且不提供循环遍历时对值 的访问。
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")

let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {//遍历数组
    print("Hello, \(name)!")
}

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {//遍历字典
    print("\(animalName)s have \(legCount) legs")
}
//字典元素的遍历顺序和插入顺序可能不同,字典的内容在内部是无序的,所以遍历元素时不能保证顺序。

//标准C样式的for循环
for var index = 0; index < 3; ++index {//Swift不需要()
    print("index is \(index)")
}




/**
*  While循环
*/
let finalSquare = 25
var board = [Int](count: finalSquare + 1, repeatedValue: 0)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

var square = 0
var diceRoll = 0
while square < finalSquare {
    // 掷骰子
    if ++diceRoll == 7 { diceRoll = 1 } // 根据点数移动
    square += diceRoll
    if square < board.count {
        // 如果玩家还在棋盘上,顺着梯子爬上去或者顺着蛇滑下去
        square += board[square]
    }
}
print("Game over!")

repeat {
    // 顺着梯子爬上去或者顺着蛇滑下去 square += board[square]
    // 掷骰子
    if ++diceRoll == 7 { diceRoll = 1 } // 根据点数移动
    square += diceRoll
} while square < finalSquare
print("Game over!")


var temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}
else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
}
else {
    print("It's not that cold. Wear a t-shirt.")
}


/**
*  Switch
*/
//switch 语句会尝试把某个值与若干个模式(pattern)进行匹配。根据第一个匹配成功的模式, switch 语句会 执行对应的代码。当有可能的情况较多时,通常用 switch 语句替换 if 语句

let someCharacter: Character = "e"
switch someCharacter {
    case "a", "e", "i", "o", "u":
        print("\(someCharacter) is a vowel")
    case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
        print("\(someCharacter) is a consonant")
    default:
        print("\(someCharacter) is not a vowel or a consonant")
}
//不存在隐式的贯穿(No Implicit Fallthrough)，不需要写break
let anotherCharacter: Character = "a"
switch anotherCharacter {
    //case "a":// Error 每一个 case 分支都必须包含至少一条语句，不能贯穿到下一个case
    //case "A":
    case "a":
        fallthrough //必须写fallthrough显式贯穿
    case "A":
        print("The letter A")
    default:
        print("Not the letter A")
}

let approximateCount = 1000
let countedThings = "moons orbiting Saturn"
var naturalCount: String
switch approximateCount {
    case 0:
        naturalCount = "no"
    case 1..<5:
        naturalCount = "a few"
    case 5..<12:
        naturalCount = "several"
    case 12..<100:
        naturalCount = "dozens of"
    case 100...1000:
        naturalCount = "hundreds of"
    default:
        naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")

/**
*  元组(Tuple)
    我们可以使用元组在同一个 switch 语句中测试多个值。
    元组中的元素可以是值,也可以是区间。另外,使用下划 线( _ )来匹配所有可能的值。
*/
let somePoint = (1, 1)
switch somePoint {
    case (0, 0):
        print("(0, 0) is at the origin")
    case (_, 0):
        print("(\(somePoint.0), 0) is on the x-axis")
    case (0, _):
        print("(0, \(somePoint.1)) is on the y-axis")
    case (-2...2, -2...2):
        print("(\(somePoint.0), \(somePoint.1)) is inside the box")
    default:
        print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}
//不像 C 语言,Swift 允许多个 case 匹配同一个值。实际上,在这个例子中,点(0, 0)可以匹配所有四个 case。
//但是,如果存在多个匹配,那么只会执行第一个被匹配到的 case 分支



/**
*  值绑定(Value Bindings)
case 分支的模式允许将匹配的值绑定到一个临时的常量或变量,这些常量或变量在该 case 分支里就可以被引用 了——这种行为被称为值绑定(value binding)
*/
let anotherPoint = (1, 2)
switch anotherPoint {
    case (let x, 0):
        print("on the x-axis with an x value of \(x)")
    case (0, let y):
        print("on the y-axis with a y value of \(y)")
    case let (x, y):
        print("somewhere else at (\(x), \(y))")
}

// Where
// case 分支的模式可以使用 where 语句来判断额外的条件
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
    case let (x, y) where x == y:
        print("(\(x), \(y)) is on the line x == y")
    case let (x, y) where x == -y:
        print("(\(x), \(y)) is on the line x == -y")
    case let (x, y):
            print("(\(x), \(y)) is just some arbitrary point")
}

/**
*  控制转移语句(Control Transfer Statements)
*/
//控制转移语句改变你代码的执行顺序,通过它你可以实现代码的跳转。
//Swift有四种控制转移语句。
// continue
// break
// fallthrough
// return
// throw (error)

// continue 语句告诉一个循环体立刻停止本次循环迭代,重新开始下次循环迭代。就好像在说“本次循环迭代我已 经执行完了”,但是并不会离开整个循环体。
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
for character in puzzleInput.characters {
    switch character {
        case "a", "e", "i", "o", "u", " ":
            continue
    default:
            puzzleOutput.append(character) }
}
print(puzzleOutput)


//break 语句会立刻结束整个控制流的执行。当你想要更早的结束一个 switch 代码块或者一个循环体时,你都可以使用 break 语句。
let numberSymbol: Character = "有" // 简体中文里的数字 3
var possibleIntegerValue: Int?
switch numberSymbol {
    case "1", "?", "一", "?":
        possibleIntegerValue = 1
    case "2", "?", "二", "?":
        possibleIntegerValue = 2
    case "3", "?", "三", "?":
        possibleIntegerValue = 3
    case "4", "?", "四", "?":
        possibleIntegerValue = 4
    default:
        break //注意: 当一个switch分支仅仅包含注释时,会被报编译时错误。注释不是代码语句而且也不能让 switch 分支达到被忽略的效果。你总是可以使用 break 来忽略某个分支。
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value could not be found for \(numberSymbol).")
}


//贯穿(Fallthrough)
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
    case 2, 3, 5, 7, 11, 13, 17, 19:
        description += " a prime number, and also"
        fallthrough
    default:
        description += " an integer."
}
print(description)

//带标签的语句

board[03] = +08; board[06] = +11; board[09] = +09
board[10] = +02;board[14] = -10; board[19] = -11
board[22] = -02; board[24] = -08;
square = 0
diceRoll = 0

gameLoop: while square != finalSquare{
    if ++diceRoll == 7 { diceRoll = 1 }
    switch square + diceRoll {
        case finalSquare:
            // 到达最后一个方块,游戏结束
            break gameLoop
        case let newSquare where newSquare > finalSquare:
            // 超出最后一个方块,再掷一次骰子
            continue gameLoop
        default:
            // 本次移动有效
            square += diceRoll
            square += board[square]
        }
}
print("Game over!")

//提前退出
//像 if 语句一样, guard 的执行取决于一个表达式的布尔值。我们可以使用 guard 语句来要求条件必须为真 时,以执行 guard 语句后的代码。不同于 if 语句,一个 guard 语句总是有一个 else 分句,如果条件不为真则 执行 else 分局中的代码。
//如果 guard 语句的条件被满足,则在保护语句的封闭大括号结束后继续执行代码。任何使用了可选绑定作为条件 的一部分并被分配了值的变量或常量对于剩下的保护语句出现的代码段是可用的。
//如果条件不被满足,在 else 分支上的代码就会被执行。这个分支必须转移控制以退出 guard 语句出现的代码 段。它可以用控制转移语句如 ￼ ￼ 或 continue 做这件事,或者它调用了一个不返回的方法或函 数,例如 fatalError() 。
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    print("Hello \(name)")
    guard let location = person["location"]
        else {
            print("I hope the weather is nice near you.")
            return
    }
    print("I hope the weather is nice in \(location).")
}
greet(["name": "John"])
greet(["name": "Jane", "location": "Cupertino"])


/**
*  检测API是否可用
    Swift 有内置支持去检查接口的可用性的,这可以确保我们不会不小心地使用对于当前部署目标不可用的API。
*/
if #available(iOS 9, OSX 10.10, *) {
    // 在 iOS 使用 iOS 9 APIs , 并且在 OS X 使用 OS X v10.10 APIs
} else {
    // 回滚至早前 iOS and OS X 的API
}
//在它普遍的形式中,可用性条件获取了平台名字和版本的清单。平台名字可以是 iOS , OSX 或 watchOS 。除 了特定的主板本号像iOS8,我们可以指定较小的版本号像iOS8.3以及 OS X v10.10.3。










