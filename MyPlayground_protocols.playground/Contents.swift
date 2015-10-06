//: Playground - noun: a place where people can play

import Cocoa

/**
*  协议（Protocols）
*
协议定义了一个蓝图，规定了用来实现某一特定工作或者功能所必需的方法和属性。类，结构体或枚举类型都可以遵循协议，并提供具体实现来完成协议定义的方法和功能。任意能够满足协议要求的类型被称为遵循(conform)这个协议。
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
//使用required修饰符可以保证：所有的遵循该协议的子类，同样能为构造器规定提供一个显式的实现或继承实现。
//注意:
//如果类已经被标记为final，那么不需要在协议构造器的实现中使用required修饰符。因为final类不能有子类。关于final修饰符的更多内容，请参见防止重写。

//如果一个子类重写了父类的指定构造器，并且该构造器遵循了某个协议的规定，那么该构造器的实现需要被同时标示required和override修饰符
protocol SomeProtocol1 {
    init()
}

class SomeSuperClass {
    init() {
        // 构造器的实现
    }
}

class SomeSubClass1: SomeSuperClass, SomeProtocol1 {
    // 因为遵循协议，需要加上"required"; 因为继承自父类，需要加上"override"
    required override init() {
        // 构造器实现
    }
}


//可失败构造器的规定
//可以通过给协议Protocols中添加可失败构造器来使遵循该协议的类型必须实现该可失败构造器。
//如果在协议中定义一个可失败构造器，则在遵顼该协议的类型中必须添加同名同参数的可失败构造器或非可失败构造器。如果在协议中定义一个非可失败构造器，则在遵循该协议的类型中必须添加同名同参数的非可失败构造器或隐式解析类型的可失败构造器（init!）。

//协议类型
//尽管协议本身并不实现任何功能，但是协议可以被当做类型来使用。
//协议可以像其他普通类型一样使用，使用场景:
//作为函数、方法或构造器中的参数类型或返回值类型
//作为常量、变量或属性的类型
//作为数组、字典或其他容器中的元素类型
/*
注意
协议是一种类型，因此协议类型的名称应与其他类型(Int，Double，String)的写法相同，使用大写字母开头的驼峰式写法，例如(FullyNamed和RandomNumberGenerator)
*/
//如下所示，这个示例中将协议当做类型来使用
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {//在调用构造方法时创建Dice的实例时，可以传入任何遵循RandomNumberGenerator协议的实例给generator
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}


//委托(代理)模式
//委托是一种设计模式，它允许类或结构体将一些需要它们负责的功能交由(委托)给其他的类型的实例。委托模式的实现很简单: 定义协议来封装那些需要被委托的函数和方法， 使其遵循者拥有这些被委托的函数和方法。委托模式可以用来响应特定的动作或接收外部数据源提供的数据，而无需要知道外部数据源的类型信息。
//下面的例子是两个基于骰子游戏的协议:
protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll:Int)
    func gameDidEnd(game: DiceGame)
}



class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    //(dice属性在构造之后就不再改变，且协议只要求dice为只读的，因此将dice声明为常量属性。)
    var square = 0
    var board: [Int]
    init() {
        board = [Int](count: finalSquare + 1, repeatedValue: 0)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?//注意:delegate并不是游戏的必备条件，因此delegate被定义为遵循DiceGameDelegate协议的可选属性。因为delegate是可选值，因此在初始化的时候被自动赋值为nil。随后，可以在游戏中为delegate设置适当的值。
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        //因为delegate是一个遵循DiceGameDelegate的可选属性，因此在play()方法中使用了可选链来调用委托方法。 若delegate属性为nil， 则delegate所调用的方法失效，并不会产生错误。若delegate不为nil，则方法能够被调用
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}


//DiceGameTracker实现了DiceGameDelegate协议规定的三个方法，用来记录游戏已经进行的轮数。 当游戏开始时，numberOfTurns属性被赋值为0; 在每新一轮中递增; 游戏结束后，输出打印游戏的总轮数。
//game在方法中被当做DiceGame类型而不是SnakeAndLadders类型，所以方法中只能访问DiceGame协议中的成员
class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        ++numberOfTurns
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()


//在扩展中添加协议成员
//即便无法修改源代码，依然可以通过扩展(Extension)来扩充已存在类型(译者注: 类，结构体，枚举等)。扩展可以为已存在的类型添加属性，方法，下标脚本，协议等成员。
//注意
//通过扩展为已存在的类型遵循协议时，该类型的所有实例也会随之添加协议中的方法


//例如TextRepresentable协议，任何想要表示一些文本内容的类型都可以遵循该协议。这些想要表示的内容可以是类型本身的描述，也可以是当前内容的版本:
protocol TextRepresentable {
    func asText() -> String
}

extension Dice: TextRepresentable {
    func asText() -> String {
        return "A \(sides)-sided dice"
    }
}
//现在，通过扩展使得Dice类型遵循了一个新的协议，这和Dice类型在定义的时候声明为遵循TextRepresentable协议的效果相同。在扩展的时候，协议名称写在类型名之后，以冒号隔开，在大括号内写明新添加的协议内容。
//现在所有Dice的实例都遵循了TextRepresentable协议:
let d12 = Dice(sides: 12,generator: LinearCongruentialGenerator())
print(d12.asText())

extension SnakesAndLadders: TextRepresentable {
    func asText() -> String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
print(game.asText())


//通过扩展补充协议声明
//当一个类型已经实现了协议中的所有要求，却没有声明为遵循该协议时，可以通过扩展(空的扩展体)来补充协议声明:
struct Hamster {
    var name: String
    func asText() -> String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.asText())

//注意
//即使满足了协议的所有要求，类型也不会自动转变，因此你必须为它做出显式的协议声明



//集合中的协议类型
//协议类型可以在集合使用，表示集合中的元素均为协议类型，下面的例子创建了一个类型为TextRepresentable的数组:
let things: [TextRepresentable] = [game,d12,simonTheHamster]
for thing in things {
    print(thing.asText())
}

//协议的继承
//协议能够继承一个或多个其他协议，可以在继承的协议基础上增加新的内容要求。协议的继承语法与类的继承相似，多个被继承的协议间用逗号分隔:
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // 协议定义
}

protocol PrettyTextRepresentable: TextRepresentable {
    func asPrettyText() -> String
}

extension SnakesAndLadders: PrettyTextRepresentable {
    func asPrettyText() -> String {
        var output = asText() + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}
print(game.asPrettyText())





//类专属协议
//你可以在协议的继承列表中,通过添加class关键字,限制协议只能适配到类（class）类型。（结构体或枚举不能遵循该协议）。该class关键字必须是第一个出现在协议的继承列表中，其后，才是其他继承协议。
protocol SomeClassOnlyProtocol: class {
    // class-only protocol definition goes here
}//协议SomeClassOnlyProtocol只能被类（class）类型适配。如果尝试让结构体或枚举类型适配该协议，则会出现编译错误。
//注意
//当协议想要定义的行为，要求（或假设）它的遵循类型必须是引用语义而非值语义时，应该采用类专属协议。




/**
*  协议合成
有时候需要同时遵循多个协议。你可以将多个协议采用protocol<SomeProtocol， AnotherProtocol>这样的格式进行组合，称为协议合成(protocol composition)。你可以在<>中罗列任意多个你想要遵循的协议，以逗号分隔。
*/
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct PersonNew: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(celebrator: protocol<Named, Aged>) {
    print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}
let birthdayPerson = PersonNew(name: "Malcolm", age: 21)
wishHappyBirthday(birthdayPerson)
//Named协议包含String类型的name属性;Aged协议包含Int类型的age属性。Person结构体遵循了这两个协议。
//wishHappyBirthday函数的形参celebrator的类型为protocol<Named，Aged>。可以传入任意遵循这两个协议的类型的实例。




//检验协议的一致性
//你可以使用is和as操作符来检查是否遵循某一协议或强制转化为某一类型。检查和转化的语法和之前相同(详情查看类型转换):
//1.is操作符用来检查实例是否遵循了某个协议
//2.as?返回一个可选值，当实例遵循协议时，返回该协议类型;否则返回nil
//3.as用以强制向下转型，如果强转失败，会引起运行时错误。
protocol HasArea {
    var area: Double { get }
}
class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}
//Circle类把area实现为基于存储型属性radius的计算型属性，Country类则把area实现为存储型属性。这两个类都遵循了HasArea协议。
//
//如下所示，Animal是一个没有实现HasArea协议的类
class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}
//当迭代出的元素遵循HasArea协议时，通过as?操作符将其可选绑定(optional binding)到objectWithArea常量上。objectWithArea是HasArea协议类型的实例，因此area属性是可以被访问和打印的。
//objects数组中元素的类型并不会因为强转而丢失类型信息，它们仍然是Circle，Country，Animal类型。然而，当它们被赋值给objectWithArea常量时，则只被视为HasArea类型，因此只有area属性能够被访问。


//对可选协议的规定
//协议可以含有可选成员，其遵循者可以选择是否实现这些成员。在协议中使用optional关键字作为前缀来定义可选成员。
//可选协议在调用时使用可选链，因为协议的遵循者可能没有实现可选内容，详细内容在可空链式调用章节中查看。
//像someOptionalMethod?(someArgument)这样，你可以在可选方法名称后加上?来检查该方法是否被实现。可选方法和可选属性都会返回一个可选值(optional value)，当其不可访问时，?之后语句不会执行，并整体返回nil

/**
*  注意
可选协议只能在含有@objc前缀的协议中生效。且@objc的协议只能被类遵循
这个前缀表示协议将暴露给Objective-C代码，详情参见《Using Swift with Cocoa and Objective-C》。即使你不打算和Objective-C有什么交互，如果你想要指明协议包含可选属性，那么还是要加上@obj前缀
*/

//下面的例子定义了一个叫Counter的整数加法类，它使用外部的数据源来实现每次的增量。数据源是两个可选属性，在CounterDataSource协议中定义:
@objc protocol CounterDataSource {
    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int { get }
}
//注意
//CounterDataSource中的属性和方法都是可选的，因此可以在类中声明都不实现这些成员，尽管技术上允许这样做，不过最好不要这样写。
class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: CounterDataSource {
    @objc let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}


class TowardsZeroSource: CounterDataSource {
    @objc func incrementForCount(count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}


//协议扩展
//使用扩展协议的方式可以为遵循者提供方法或属性的实现。通过这种方式，可以让你无需在每个遵循者中都实现一次，无需使用全局函数，你可以通过扩展协议的方式进行定义。
extension RandomNumberGenerator {
    func randomBool() -> Bool {//可以扩展RandomNumberGenerator协议，让其提供randomBool()方法
        return random() > 0.1
    }
}
//通过扩展协议，所有协议的遵循者，在不用任何修改的情况下，都自动得到了这个扩展所增加的方法。
let generator1 = LinearCongruentialGenerator()
print("Here's a random number: \(generator1.random())")
print("And here's a random Boolean: \(generator1.randomBool())")
print("And here's a random Boolean: \(generator.randomBool())")

//提供默认实现
//可以通过协议扩展的方式来为协议规定的属性和方法提供默认的实现。
//如果协议的遵循者对规定的属性和方法提供了自己的实现，那么遵循者提供的实现将被使用。
//注意
//通过扩展协议提供的协议实现和可选协议规定有区别。虽然协议遵循者无需自己实现，通过扩展提供的默认实现，可以不是用可选链调用。

//例如，PrettyTextRepresentable协议，继承了TextRepresentable协议，可以为其提供一个默认的asPrettyText()方法来简化返回值
extension PrettyTextRepresentable  {
    func asPrettyText() -> String {
        return asText()
    }
}



//为协议扩展添加限制条件
//在扩展协议的时候，可以指定一些限制，只有满足这些限制的协议遵循者，才能获得协议扩展提供的属性和方法。这些限制写在协议名之后，使用where关键字来描述限制情况。(Where语句)。:
//例如，你可以扩展CollectionType协议，但是只适用于元素遵循TextRepresentable的情况:
extension CollectionType where Generator.Element : TextRepresentable {
    func asList() -> String {
        var rtnString:String = "("
        rtnString.appendContentsOf(map({$0.asText()}).description+")")
        return rtnString
    }
}
let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]
print(hamsters.asList())
//注意
//如果有多个协议扩展，而一个协议的遵循者又同时满足它们的限制，那么将会使用所满足限制最多的那个扩展。


