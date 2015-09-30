//: Playground - noun: a place where people can play

import Cocoa

/**
*  枚举 Enumerations
枚举定义了一个通用类型的一组相关值,使你可以在你的代码中以一种安全的方式来使用这些值。
Swift 中的枚举更加灵活,不必给每一个枚举成员提供一个值。如果给枚举成员提供一个值(称为“原始”值),则该值的类型可以是字符 串,字符,或是一个整型值或浮点数。
此外,枚举成员可以指定任何类型的相关值存储到枚举成员值中,就像其他语言中的联合体(unions)和变 体(variants)。

在 Swift 中,枚举类型是一等公民(first-class)。它们采用了很多传统上只被类(class)所支持的特征,例如 计算型属性(computed properties),用于提供关于枚举当前值的附加信息, 实例方法(instance method s),用于提供和枚举所代表的值相关联的功能。枚举也可以定义构造函数(initializers)来提供一个初始值;可 以在原始的实现基础上扩展它们的功能;可以遵守协议(protocols)来提供标准的功能。
*/


//枚举语法
enum CompassPoint {
    case North
    case South
    case East
    case West
}
//注意:
//和 C 和 Objective-C 不同,Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。在上面的Points 例子中, North , South , East 和 West 不会隐式地赋值为了 0 , 1 , 2 和 3 。相反的,这些不 同的枚举成员在 CompassPoint 的一种显示定义中拥有各自不同的值。

enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}//每个枚举定义了一个全新的类型。像 Swift 中其他类型一样,它们的名字(例如 CompassPoint 和 Planet )必须以一个大写字母开头

var directionToHead = CompassPoint.West
directionToHead = .South
switch directionToHead {
    case .North:
        print("Lots of planets have a north")
    case .South:
        print("Watch out for penguins")
    case .East:
        print("Where the sun rises")
    case .West:
        print("Where the skies are blue")
    //default: //对一个枚举类型进行了switch穷举，就不需要default
      //  print("What a mass!")
}


//相关值(Associated Values)
enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}
var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)
print(productBarcode)
productBarcode = .QRCode("ABCDEFGHIJKLMNOP")
//这时,原始的 Barcode.UPCA 和其整数值被新的 Barcode.QRCode 和其字符串值所替代。条形码的常量和变 量可以存储一个 .UPCA 或者一个 .QRCode (连同它的相关值),但是在任何指定时间只能存储其中之一。
switch productBarcode {
    case .UPCA(let numberSystem, let manufacturer, let product, let check):
        print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
    case .QRCode(let productCode):
        print("QR code: \(productCode).")
}

//简洁写法
switch productBarcode {
    case let .UPCA(numberSystem, manufacturer, product, check):
        print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
    case let .QRCode(productCode):
        print("QR code: \(productCode).")
}

//原始值(Raw Values)
//作为相关值的另一种选择,枚举成员可以被默认值(称为原始值)赋值,其中这些原始值具有相同的类型。
enum ASCIIControlCharacter: Character {//原始值可以是字符串,字符,或者任何整型值或浮点型值。每个原始值在它的枚举声明中必须是唯一的。
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}
/**
*  注意: 原始值和相关值是不相同的。当你开始在你的代码中定义枚举的时候原始值是被预先填充的值,像上述三个ASCII码。
    对于一个特定的枚举成员,它的原始值始终是相同的。
    相关值是当你在创建一个基于枚举成员的新常量或变量时才会被设置,并且每次当你这么做得时候,它的值可以是不同的。
*/

//原始值的隐式赋值(Implicitly Assigned Raw Values)
//在使用原始值为整数或者字符串类型的枚举时,不需要显式的为每一个成员赋值,这时,Swift将会自动为你赋 值。
//例如,当使用整数作为原始值时,隐式赋值的值依次递增1。如果第一个值没有被赋初值,将会被自动置为0。
enum PlanetNew: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
print(PlanetNew.Earth.rawValue)
enum CompassPointNew: String {
    case North, South, East, West
}
print(CompassPoint.East)


//使用原始值初始化枚举变量(Initializing from a Raw Value)
//使用原始值来初始化
let possiblePlanet = PlanetNew(rawValue: 7)
print(possiblePlanet == PlanetNew.Uranus)
//注意:原始值构造器是一个可失败构造器,因为并不是每一个原始值都有与之对应的枚举成员。更多信息请参见可失败构造器
//let possiblePlanet = PlanetNew(rawValue: 7)将会得到nil



//递归枚举(Recursive Enumerations)
//表示它的枚举中,有一个或多个枚举成员拥有该枚举的 其他成员作为相关值。使用递归枚举时,编译器会插入一个中间层。你可以在枚举成员前加上 indirect 来表示这 成员可递归。
enum ArithmeticExpression {
    case Number(Int)
    indirect case Addition(ArithmeticExpression, ArithmeticExpression)
    indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
}

indirect enum ArithmeticExpressionNew {
    case Number(Int)
    case Addition(ArithmeticExpression, ArithmeticExpression)
    case Multiplication(ArithmeticExpression, ArithmeticExpression)
}
//上面定义的枚举类型可以存储三种算数表达式:纯数字、两个表达式的相加、两个表达式相乘。

func evaluate(expression: ArithmeticExpression) -> Int {
    switch expression {
        case .Number(let value):
            return value
        case .Addition(let left, let right):
            return evaluate(left) + evaluate(right)
        case .Multiplication(let left, let right):
            return evaluate(left) * evaluate(right)
    }
}


let five = ArithmeticExpression.Number(5)
let four = ArithmeticExpression.Number(4)
let sum = ArithmeticExpression.Addition(five, four)
let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))
print(evaluate(product))
//该函数如果遇到纯数字,就直接返回该数字的值。如果遇到的是加法或乘法元算,则分别计算左边表达式和右边表达式的值,然后相加或相乘。


