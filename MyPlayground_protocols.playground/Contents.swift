//: Playground - noun: a place where people can play

import Cocoa

/**
*  协议（Protocols）
*
协议定义了一个蓝图，规定了用来实现某一特定工作或者功能所必需的方法和属性。类，结构体或枚举类型都可以遵循协议，并提供具体实现来完成协议定义的方法和功能。任意能够满足协议要求的类型被称为遵循(conform)这个协议。

内容：
协议的语法（Protocol Syntax）
对属性的规定（Property Requirements）
对方法的规定（Method Requirements）
对Mutating方法的规定（Mutating Method Requirements）
对构造器的规定（Initializer Requirements）
协议类型（Protocols as Types）
委托(代理)模式（Delegation）
在扩展中添加协议成员（Adding Protocol Conformance with an Extension）
通过扩展补充协议声明（Declaring Protocol Adoption with an Extension）
集合中的协议类型（Collections of Protocol Types）
协议的继承（Protocol Inheritance）
类专属协议（Class-Only Protocol）
协议合成（Protocol Composition）
检验协议的一致性（Checking for Protocol Conformance）
对可选协议的规定（Optional Protocol Requirements）
协议扩展（Protocol Extensions）
*/

/*协议的语法
协议的定义方式与类，结构体，枚举的定义非常相似。

protocol SomeProtocol {
// 协议内容
}
*/

/*
要使类遵循某个协议，需要在类型名称后加上协议名称，中间以冒号:分隔，作为类型定义的一部分。
遵循多个协议时，各协议之间用逗号,分隔。
struct SomeStructure: FirstProtocol, AnotherProtocol {
// 结构体内容
}
*/
/*
如果类在遵循协议的同时拥有父类，应该将父类名放在协议名之前，以逗号分隔。
class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
// 类的内容
}
*/
//对属性的规定
//协议可以规定其遵循者提供特定名称和类型的实例属性(instance property)或类属性(type property)，而不指定是存储型属性(stored property)还是计算型属性(calculate property)。此外还必须指明是只读的还是可读可写的。
//如果协议规定属性是可读可写的，那么这个属性不能是常量或只读的计算属性。如果协议只要求属性是只读的(gettable)，那个属性不仅可以是只读的，如果你代码需要的话，也可以是可写的。
//协议中的通常用var来声明属性，在类型声明后加上{ set get }来表示属性是可读可写的，只读属性则用{ get }来表示。

protocol SomeProtocol {
    var mustBeSettable : Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}




//在协议中定义类属性(type property)时，总是使用static关键字作为前缀。当协议的遵循者是类时，可以使用class或static关键字来声明类属性，但是在协议的定义中，仍然要使用static关键字。
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

//如下所示，这是一个含有一个实例属性要求的协议。
protocol FullyNamed {
    var fullName: String { get }
}
//FullyNamed协议除了要求协议的遵循者提供fullName属性外，对协议对遵循者的类型并没有特别的要求。
//这个协议表示，任何遵循FullyNamed协议的类型，都具有一个可读的String类型实例属性fullName。
struct Person: FullyNamed{ //Person结构体的每一个实例都有一个叫做fullName，String类型的存储型属性。这正好满足了FullyNamed协议的要求，也就意味着，Person结构体完整的遵循了协议。(如果协议要求未被完全满足,在编译时会报错)
    var fullName: String
}
let john = Person(fullName: "John Appleseed")


//下面是一个更为复杂的类，它采用并遵循了FullyNamed协议:
class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
print(ncc1701.fullName)
//Starship类把fullName属性实现为只读的计算型属性。每一个Starship类的实例都有一个名为name的属性和一个名为prefix的可选属性。 当prefix存在时，将prefix插入到name之前来为Starship构建fullName，prefix不存在时，则将直接用name构建fullName。


//对方法的规定
//协议可以要求其遵循者实现某些指定的实例方法或类方法。这些方法作为协议的一部分，像普通的方法一样放在协议的定义中，但是不需要大括号和方法体。
//可以在协议中定义具有可变参数的方法，和普通方法的定义方式相同。但是在协议的方法定义中，不支持参数默认值。
//正如对属性的规定中所说的，在协议中定义类方法的时候，总是使用static关键字作为前缀。当协议的遵循者是类的时候，虽然你可以在类的实现中使用class或者static来实现类方法，但是在协议中声明类方法，仍然要使用static关键字。
protocol OneProtocol {
    static func someTypeMethod()
}

//下面的例子定义了含有一个实例方法的协议。
protocol RandomNumberGenerator {
    func random() -> Double
}
//RandomNumberGenerator协议要求其遵循者必须拥有一个名为random， 返回值类型为Double的实例方法。尽管这里并未指明，但是我们假设返回值在[0，1)区间内。
//RandomNumberGenerator协议并不在意每一个随机数是怎样生成的，它只强调这里有一个随机数生成器。
//如下所示，下边的是一个遵循了RandomNumberGenerator协议的类。该类实现了一个叫做线性同余生成器(linear congruential generator)的伪随机数算法。

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And another one: \(generator.random())")



/**
*  对Mutating方法的规定
有时需要在方法中改变它的实例。例如，值类型(结构体，枚举)的实例方法中，将mutating关键字作为函数的前缀，写在func之前，表示可以在该方法中修改它所属的实例及其实例属性的值。这一过程在在实例方法中修改值类型章节中有详细描述。

如果你在协议中定义了一个方法旨在改变遵循该协议的实例，那么在协议定义时需要在方法前加mutating关键字。这使得结构和枚举遵循协议并满足此方法要求。

注意:
用类实现协议中的mutating方法时，不用写mutating关键字;用结构体，枚举实现协议中的mutating方法时，必须写mutating关键字。
如下所示，Togglable协议含有名为toggle的实例方法。根据名称推测，toggle()方法将通过改变实例属性，来切换遵循该协议的实例的状态。

toggle()方法在定义的时候，使用mutating关键字标记，这表明当它被调用时该方法将会改变协议遵循者实例的状态。
*/
protocol Togglable {
    mutating func toggle()
}
//当使用枚举或结构体来实现Togglable协议时，需要提供一个带有mutating前缀的toggle方法。
//下面定义了一个名为OnOffSwitch的枚举类型。这个枚举类型在两种状态之间进行切换，用枚举成员On和Off表示。枚举类型的toggle方法被标记为mutating以满足Togglable协议的要求。
enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}
var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()
lightSwitch.toggle()


//对构造器的规定
//协议可以要求它的遵循者实现指定的构造器。你可以像书写普通的构造器那样，在协议的定义里写下构造器的声明，但不需要写花括号和构造器的实体：
protocol TwoProtocol {
    init(someParameter: Int)
}


//协议构造器规定在类中的实现
//你可以在遵循该协议的类中实现构造器，并指定其为类的指定构造器(designated initializer)或者便利构造器(convenience initializer)。在这两种情况下，你都必须给构造器实现标上"required"修饰符：
class SomeClass: TwoProtocol {
    required init(someParameter: Int) {
        //构造器实现
    }
}


