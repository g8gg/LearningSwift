//: Playground - noun: a place where people can play

import Cocoa

//类和结构体(Classes and Structures)
//类和结构体是人们构建代码所用的一种通用且灵活的构造体。我们可以使用完全相同的语法规则来为类和结构体定义属性(常量、变量)和添加方法,从而扩展类和结构体的功能。
//区别：Swift并不要求你为自定义类和结构去创建独立的接口和实现文件。你所要做的是在一个单一文件中定义一个类或者结构体,系统将会自动生成面向其它代码的外部接口。
//注意: 通常一个 类 的实例被称为对象 。然而在Swift中,类和结构体的关系要比在其他语言中更加的密切,本章中所讨论的大部分功能都可以用在类和结构体上。因此,我们会主要使用实例而不是对象

//类和结构体对比
//Swift中类和结构体有很多共同点。共同处在于:
// 1. 定义属性用于存储值
// 2. 定义方法用于提供功能
// 3. 定义附属脚本用于访问值
// 4. 定义构造器用于生成初始化值
// 5. 通过扩展以增加默认实现的功能 
// 6. 实现协议以提供某种标准功能
//与结构体相比,类还有如下的附加功能:
// 1. 继承允许一个类继承另一个类的特征
// 2. 类型转换允许在运行时检查和解释一个类实例的类型
// 3. 解构器允许一个类实例释放任何其所被分配的资源
// 4. 引用计数允许对一个类的多次引用
/**
*  注意: 结构体总是通过被复制的方式在代码中传递,因此请不要使用引用计数。
*/

/**
*  定义
*/

//类和结构体有着类似的定义方式。我们通过关键字 class 和 struct 来分别表示类和结构体,并在一对大括号中定 义它们的具体内容:
class SomeClass {
    // class definition goes here
}
struct SomeStructure {
// structure definition goes here 
}
/**
*  注意: 在你每次定义一个新类或者结构体的时候,实际上你是有效地定义了一个新的 Swift 类型。因此请使用 UpperCamelCase 这种方式来命名(如 SomeClass 和 SomeStructure 等),以便符合标准Swift 类型的
大写命名风格(如 String , Int 和 Bool )。相反的,请使用 lowerCamelCase 这种方式为属性和方法命 名(如 framerate 和 incrementCount ),以便和类区分。
*/


//定义
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}


let someResolution = Resolution()
let someVideoMode = VideoMode()
//结构体和类都使用构造器语法来生成新的实例。构造器语法的最简单形式是在结构体或者类的类型名称后跟随一对空括号
//通过这种方式所创建的类或者结构体实例,其属性均会被初始化为默认值



//属性访问
//通过使用点语法(dot syntax),你可以访问实例中所含有的属性。其语法规则是,实例名后面紧跟属性名,两 者通过点号(.)连接
print("The width of someResolution is \(someResolution.width)")
print("The width of someVideoMode is \(someVideoMode.resolution.width)")

//可以使用点语法为属性变量赋值
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
//注意: 与 Objective-C 语言不同的是,Swift 允许直接设置结构体属性的子属性。上面的最后一个例子,就是 直接设置了 someVideoMode 中 resolution 属性的 width 这个子属性,以上操作并不需要重新设置 resolution 属性。


//结构体类型的成员逐一构造器(Memberwise Initializers for Structure Types)
//所有结构体都有一个自动生成的成员逐一构造器,用于初始化新结构体实例中成员的属性。
//新实例中各个属性的初始值可以通过属性的名称传递到成员逐一构造器之中:
let vga = Resolution(width:640, height: 480)
//与结构体不同,类实例没有默认的成员逐一构造器。





/**
*  结构体和枚举是值类型
*/
//值类型被赋予给一个变量、常量或者本身被传递给一个函数的时候,实际上操作的是其的拷贝
//在 Swift 中,所有的基本类型:整数(Integer)、浮点 数(floating-point)、布尔值(Boolean)、字符串(string)、数组(array)和字典(dictionary),都是值 类型,并且都是以结构体的形式在后台所实现。
//在 Swift 中,所有的结构体和枚举类型都是值类型。这意味着它们的实例,以及实例中所包含的任何值类型属 性,在代码中传递的时候都会被复制。
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")
print("hd is still \(hd.width ) pixels wide")
//在将 hd 赋予给 cinema 的时候,实际上是将 hd 中所存储的 值(values) 进行拷贝,然后将拷贝的数据存储到 新的 cinema 实例中。结果就是两个完全独立的实例碰巧包含有相同的数值。由于两者相互独立,因此将 cinem a 的 width 修改为 2048 并不会影响 hd 中的 width 的值

//枚举也遵循相同的行为准则
enum CompassPoint {
    case North, South, East, West
}
var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    print("The remembered direction is still .West") }
//枚举也遵循相同的行为准则


/**
*  类是引用类型
*/
//与值类型不同,引用类型在被赋予到一个变量、常量或者被传递到一个函数时,操作的是引用,其并不是拷贝。因此,引用的是已存在的实例本身而不是其拷贝。
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
//因为类是引用类型,所以 tenEight 和 alsoTenEight 实际上引用的是相同的 VideoMode 实例。换句话说,它们 是同一个实例的两种叫法。
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
//需要注意的是 tenEighty 和 alsoTenEighty 被声明为常量((constants)而不是变量。然而你依然可以改变tenEighty.frameRate 和 alsoTenEighty.frameRate ,因为这两个常量本身不会改变。它们并不存储这个VideMode 实例,在后台仅仅是对 VideoMode 实例的引用。所以,改变的是被引用的基础 VideoMode 的 frameRate 参数,而不改变常量的值。


//恒等运算符
//因为类是引用类型,有可能有多个常量和变量在后台同时引用某一个类实例。(对于结构体和枚举来说,这并不成立。因为它们作为值类型,在被赋予到常量、变量或者传递到函数时,其值总是会被拷贝。)
//运算符:
// 1. 等价于 ( === )
// 2. 不等价于 ( !== )
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same Resolution instance.")
}
//请注意 “等价于" (用三个等号表示,===) 与 “等于" (用两个等号表示,==)的不同: 
//“等价于”表示两个类类型(class type)的常量或者变量引用同一个类实例。
//“等于”表示两个实例的值“相等”或“相同”,判定时要遵照类设计者定义定义的评判标准,因此相比于“相等”,这是一种更加合适的叫法。
//当你在定义你的自定义类和结构体的时候,你有义务来决定判定两个实例“相等”的标准。

//指针
//如果你有 C,C++ 或者 Objective-C 语言的经验,那么你也许会知道这些语言使用指针来引用内存中的地 址。一个 Swift 常量或者变量引用一个引用类型的实例与 C 语言中的指针类似,不同的是并不直接指向内存中的 某个地址,而且也不要求你使用星号(*)来表明你在创建一个引用。Swift 中这些引用与其它的常量或变量的定 义方式相同。



/**
*  类和结构体的选择
*/
//按照通用的准则,当符合一条或多条以下条件时,请考虑构建结构体:
// 1.结构体的主要目的是用来封装少量相关简单数据值。
// 2.有理由预计一个结构体实例在赋值或传递时,封装的数据将会被拷贝而不是被引用。 
// 3.任何在结构体中储存的值类型属性,也将会被拷贝,而不是被引用。
// 4.结构体不需要去继承另一个已存在类型的属性或者行为。


//字符串(String)、数组(Array)、和字典(Dictionary)类型的赋值与复制行为
//Swift 中 ￼ ￼ 和 字典(Dictionary) 类型均以结构体的形式实现。这意味着Strin g,Array,Dictionary类型数据被赋值给新的常量或变量,或者被传入函数或方法中时,它们的值会发生拷贝行 为(值传递方式)
//Objective-C中 ￼￼NSString和NSArray和字典(NSDictionary) 类型均以类的形式实现,这 与Swfit中以值传递方式是不同的。NSString,NSArray,NSDictionary在发生赋值或者传入函数(或方 法)时,不会发生值拷贝,而是传递已存在实例的引用。
//注意: 以上是对于字符串、数组、字典和其它值的 拷贝 的描述。 在你的代码中,拷贝好像是确实是在有拷贝 行为的地方产生过。然而,在 Swift 的后台中,只有确有必要, 实际(actual) 拷贝才会被执行。Swift 管理所 有的值拷贝以确保性能最优化的性能,所以你也没有必要去避免赋值以保证最优性能。(实际赋值由系统管理优 化)


/**
*  属性 (Properties)
*/
//属性将值跟特定的类、结构或枚举关联。存储属性存储常量或变量作为实例的一部分,而计算属性计算(不是存储)一个值。计算属性可以用于类、结构体和枚举,存储属性只能用于类和结构体。
//存储属性和计算属性通常与特定类型的实例关联。但是,属性也可以直接作用于类型本身,这种属性称为类型属性。
//另外,还可以定义属性观察器来监控属性值的变化,以此来触发一个自定义的操作。属性观察器可以添加到自己定义的存储属性上,也可以添加到从父类继承的属性上。

//存储属性
//简单来说,一个存储属性就是存储在特定类或结构体的实例里的一个常量或变量。存储属性可以是变量存储属性(用关键字 var 定义),也可以是常量存储属性(用关键字 let 定义)
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6

//常量结构体的存储属性
//let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//rangeOfFourItems.firstValue = 6
//尽管 firstValue 是个变量属性,这里还是会报错
//因为 rangeOfFourItems 被声明成了常量(用 let 关键字),即使 firstValue 是一个变量属性,也无法再修改它 了。
//这种行为是由于结构体(struct)属于值类型。当值类型的实例被声明为常量的时候,它的所有属性也就成了常量。
//属于引用类型的类(class)则不一样。把一个引用类型的实例赋给一个常量后,仍然可以修改该实例的变量属性。


//延迟存储属性
//延迟存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 lazy 来标示一个延迟存储属性
//注意:
//必须将延迟存储属性声明成变量(使用 var 关键字),因为属性的初始值可能在实例构造完成之后才会得 到。而常量属性在构造过程完成之前必须要有初始值,因此无法声明成延迟属性。
//延迟属性很有用,当属性的值依赖于在实例的构造过程结束后才会知道具体值的外部因素时,或者当获得属性的初始值需要复杂或大量计算时,可以只在需要的时候计算它。
//下面的例子使用了延迟存储属性来避免复杂类中不必要的初始化。
class DataImporter {
    /*
    DataImporter 是一个将外部文件中的数据导入的类。 这个类的初始化会消耗不少时间。
    */
    var fileName = "data.txt" // 这是提供数据导入功能
}
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // 这是提供数据管理功能
}
let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// DataImporter 实例的 importer 属性还没有被创建

//由于使用了lazy, importer属性只有在第一次被访问的时候才被创建。比如访问它的属性 fileName 时:
print(manager.importer.fileName)
//如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问,则无法保证该属性只会被初始化一次。

//存储属性和实例变量
//Objective-C为类实例存储值和引用提供两种方法。对于属性来说,也可以使用实例变量作为属性值的后端存储。
//Swift 编程语言中把这些理论统一用属性来实现。Swift 中的属性没有对应的实例变量,属性的后端存储也无法直 接访问。这就避免了不同场景下访问方式的困扰,同时也将属性的定义简化成一个语句。一个类型中属性的全部 信息——包括命名、类型和内存管理特征——都在唯一一个地方(类型定义中)定义。





//计算属性
//除存储属性外,类、结构体和枚举可以定义计算属性。计算属性不直接存储值,而是提供一个 getter 和一个可选 的 setter,来间接获取和设置其他属性或变量的值。
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0 }
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2) }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
//Rect也提供了一个名为Center的计算属性。一个矩形的中心点可以从原点(origin)和尺寸(size)算 出,所以不需要将它以显式声明的 ￼ 来保存。 的计算属性 ￼ 提供了自定义的 getter 和 setter 来 获取和设置矩形的中心点,就像它有一个存储属性一样。

//便捷 setter 声明
//如果计算属性的 setter 没有定义表示新值的参数名,则可以使用默认名称 newValue 。
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//只读计算属性
//只有 getter 没有 setter 的计算属性就是只读计算属性。只读计算属性总是返回一个值,可以通过点运算符访 问,但不能设置新的值。
//注意:
//必须使用 var 关键字定义计算属性,包括只读计算属性,因为它们的值不是固定的。 let 关键字只用来声明常 量属性,表示初始化后再也无法修改的值。
//只读计算属性的声明可以去掉 get 关键字和花括号:
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
    return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")



//属性观察器
//属性观察器监控和响应属性值的变化,每次属性被设置值的时候都会调用属性观察器,甚至新的值和现在的值相同的时候也不例外。
//可以为除了延迟存储属性之外的其他存储属性添加属性观察器,也可以通过重载属性的方式为继承的属性(包括 存储属性和计算属性)添加属性观察器。
//注意: 不需要为非重载的计算属性添加属性观察器,因为可以通过它的 setter 直接监控和响应值的变化。

//可以为属性添加如下的一个或全部观察器:
// 1.willSet 在新的值被设置之前调用
// 2.didSet 在新的值被设置之后立即调用
//willSet 观察器会将新的属性值作为常量参数传入,在 willSet 的实现代码中可以为这个参数指定一个名称,如果不指定则参数仍然可用,这时使用默认名称 newValue 表示。
//类似地, didSet 观察器会将旧的属性值作为参数传入,可以为该参数命名或者使用默认参数名 oldValue 。
//注意:
//父类的属性在子类的构造器中被赋值时,它在父类中的 willSet 和 didSet 观察器会被调用。


class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            } }
    } }

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps 
stepCounter.totalSteps = 360
// About to set totalSteps to 360 
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896 
// Added 536 steps


/**
*  全局变量和局部变量
*/
//计算属性和属性观察器所描述的模式也可以用于全局变量和局部变量。全局变量是在函数、方法、闭包或任何类型之外定义的变量。局部变量是在函数、方法或闭包内部定义的变量。
//注意:
//全局的常量或变量都是延迟计算的,跟延迟存储属性相似,不同的地方在于,全局的常量或变量不需要标 记 lazy 特性。局部范围的常量或变量不会延迟计算。

/**
*  类型属性
*/
//实例的属性属于一个特定类型实例,每次类型实例化后都拥有自己的一套属性值,实例之间的属性相互独立。
//也可以为类型本身定义属性,不管类型有多少个实例,这些属性都只有唯一一份。这种属性就是类型属性。
//类型属性用于定义特定类型所有实例共享的数据,比如所有实例都能用的一个常量(就像 C 语言中的静态常量),或者所有实例都能访问的一个变量(就像 C 语言中的静态变量)。
//值类型的存储型类型属性可以是变量或常量,计算型类型属性跟实例的计算属性一样只能定义成变量属性。
//注意:
//跟实例的存储属性不同,必须给存储型类型属性指定默认值,因为类型本身无法在初始化过程中使用构造器给类型属性赋值。

//类型属性语法
//在 C 或 Objective-C 中,与某个类型关联的静态常量和静态变量,是作为全局(global)静态变量定义的。
//但是在 Swift 编程语言中,类型属性是作为类型定义的一部分写在类型最外层的花括号内,因此它的作用范围也就在类型支持的范围内。
//使用关键字 static 来定义类型属性。在为类(class)定义计算型类型属性时,可以使用关键字 class 来支持子类对父类的实现进行重写。
//下面的例子演示了存储型和计算型类型属性的语法:
struct SomeStructureNew {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1 }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6 }
}
class SomeClassNew {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
//注意:例子中的计算型类型属性是只读的,但也可以定义可读可写的计算型类型属性,跟实例计算属性的语法类似。



//获取和设置类型属性的值
//跟实例的属性一样,类型属性的访问也是通过点运算符来进行。但是,类型属性是通过类型本身来获取和设置,而不是通过实例。
print(SomeStructureNew.storedTypeProperty)
// 输出 "Some value." 
SomeStructureNew.storedTypeProperty = "Another value."
print(SomeStructureNew.storedTypeProperty)
// 输出 "Another value.” 
print(SomeEnumeration.computedTypeProperty) // 输出 "6" 
print(SomeClassNew.computedTypeProperty)
// 输出 "27"




/**
*  下面的例子定义了一个结构体,使用两个存储型类型属性来表示多个声道的声音电平值,每个声道有一个 0 到 10 之间的整数表示声音电平值。
后面的图表展示了如何联合使用两个声道来表示一个立体声的声音电平值。当声道的电平值是 0,没有一个灯会 亮;当声道的电平值是 10,所有灯点亮。本图中,左声道的电平是 9,右声道的电平是 7。
*/

//上面所描述的声道模型使用 AudioChannel 结构体的实例来表示:
struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // 将新电平值设置为阀值
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // 存储当前电平值作为新的最大输入电平 
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()
leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
print(rightChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)
rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
// 输出 "10" 
print(AudioChannel.maxInputLevelForAllChannels) // 输出 "10"


/**
*  方法(Methods)
*/
//方法是与某些特定类型相关联的函数
//类、结构体、枚举都可以定义实例方法;实例方法为给定类型的实例封装 了具体的任务与功能。类、结构体、枚举也可以定义类型方法;类型方法与类型本身相关联。类型方法与 Objecti ve-C 中的类方法(class methods)相似
//结构体和枚举能够定义方法是 Swift 与 C/Objective-C 的主要区别之一
//在 Objective-C 中,类是唯一能定义 方法的类型。但在 Swift 中,你不仅能选择是否要定义一个类/结构体/枚举,还能灵活的在你创建的类型(类/结 构体/枚举)上定义方法

//实例方法 (Instance Methods)
//实例方法是属于某个特定类、结构体或者枚举类型实例的方法。
//实例方法提供访问和修改实例属性的方法或提供与实例目的相关的功能,并以此来支撑实例的功能。实例方法的语法与函数完全一致
//实例方法要写在它所属的类型的前后大括号之间。实例方法能够隐式访问它所属类型的所有的其他实例方法和属性。
//实例方法只能被它所属的类的某个特定实例调用。
//实例方法不能脱离于现存的实例而被调用。

class Counter {
    var count = 0
    func increment() {
        ++count
    }
    func incrementBy(amount: Int) {
        count += amount
    }
    func reset() {
        count = 0 }
}
let counter = Counter() // 初始计数值是0
print(counter.count)
counter.increment()
print(counter.count)
counter.incrementBy(5) // 计数值现在是6 
print(counter.count)
counter.reset()
print(counter.count)



//方法的局部参数名称和外部参数名称(Local and External Parameter Names for Methods)
//函数参数可以同时有一个局部名称(在函数体内部使用)和一个外部名称(在调用函数时使用)
//方法参数也一样(因为方法就是函数,只是这个函数与某个类型相关联了)
//Swift 中的方法和 Objective-C 中的方法极其相似。像在 Objective-C 中一样,Swift 中方法的名称通常用一个 介词指向方法的第一个参数,比如: with , for , by 等等。前面的 Counter 类的例子中 incrementBy(_:) 方 法就是这样的。介词的使用让方法在被调用时能像一个句子一样被解读。
//具体来说,Swift 默认仅给方法的第一个参数名称一个局部参数名称;默认同时给第二个和后续的参数名称局部参 数名称和外部参数名称。这个约定与典型的命名和调用约定相适应,与你在写 Objective-C 的方法时很相似。这 个约定还让表达式方法在调用时不需要再限定参数名称。
class CounterNew {
    var count: Int = 0
    func incrementBy(amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
}
//默认情况下,Swift 只把 amount 当作一个局部名称,但是把 numberOfTimes 即看作局部名称又看作外部名称。
let counter1 = CounterNew()
counter1.incrementBy(5, numberOfTimes: 3) // counter1 的值现在是 15
print(counter1.count)

//修改方法的外部参数名称(Modifying External Parameter Name Behavior for Methods)
//有时为方法的第一个参数提供一个外部参数名称是非常有用的,尽管这不是默认的行为。你可以自己添加一个显式的外部名称或者用一个井号( # )作为第一个参数的前缀来把这个局部名称当作外部名称使用。
//相反,如果你不想为方法的第二个及后续的参数提供一个外部名称,可以通过使用下划线( _ )作为该参数的显式外部名称,这样做将覆盖默认行为。

/**
*  self 属性(The self Property)
*/
//类型的每一个实例都有一个隐含属性叫做 self , 
//self 完全等同于该实例本身。你可以在一个实例的实例方法中 使用这个隐含的 self 属性来引用当前实例。

/** 上面例子中的 increment 方法还可以这样写:
*  func increment() { 
    self.count++
    }
使用这条规则的主要场景是实例方法的某个参数名称与实例的某个属性名称相同的时候。在这种情况下,参数名 称享有优先权,并且在引用属性时必须使用一种更严格的方式。这时你可以使用 self 属性来区分参数名称和属性名称。
*/


//下面的例子中, self 消除方法参数 x 和实例属性 x 之间的歧义:
struct MyPoint {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x }
}
let somePoint = MyPoint(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(1.0) {
    print("This point is to the right of the line where x == 1.0")
}




//在实例方法中修改值类型(Modifying Value Types from Within Instance Methods)
//结构体和枚举是值类型。一般情况下,值类型的属性不能在它的实例方法中被修改。
//但是,如果你确实需要在某个具体的方法中修改结构体或者枚举的属性,你可以选择 变异(mutating) 这个方 法,然后方法就可以从方法内部改变它的属性;并且它做的任何改变在方法结束时还会保留在原始结构中。方法还可以给它隐含的 self 属性赋值一个全新的实例,这个新实例在方法结束后将替换原来的实例。
struct PointNew {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePointNew = PointNew(x: 1.0, y: 1.0)
somePointNew.moveByX(2.0, y: 3.0)
print("The point is now at (\(somePointNew.x), \(somePointNew.y))")
//上面的 Point 结构体定义了一个变异方法(mutating method) moveByX(_:y:) 用来移动点。 moveByX 方法 在被调用时修改了这个点,而不是返回一个新的点。方法定义时加上 mutating 关键字,这才让方法可以修改值 类型的属性。


//注意:不能在结构体类型常量上调用变异方法,因为常量的属性不能被改变,即使想改变的是常量的变量属性也 不行
//let fixedPoint = PointNew(x: 3.0, y: 3.0)
//fixedPoint.moveByX(2.0, y: 3.0)
// 这里将会抛出一个错误


//在变异方法中给self赋值(Assigning to self Within a Mutating Method)
struct PointRenew {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        self = PointRenew(x: x + deltaX, y: y + deltaY) }
}

var pointRenew=PointRenew(x:1.0, y:1.0)
pointRenew.moveByX(12.0, y: 12.0)
print(pointRenew.x,pointRenew.y)
//新版的变异方法 moveByX(_:y:) 创建了一个新的结构(它的 x 和 y 的值都被设定为目标值)。调用这个版本的 方法和调用上个版本的最终结果是一样的。


//枚举的变异方法可以把 self 设置为相同的枚举类型中不同的成员:
enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
            case Off:
                self = Low
            case Low:
                self = High
            case High:
                self = Off
        }
    }
}
var ovenLight = TriStateSwitch.Low
ovenLight.next()
// ovenLight 现在等于 .High 
ovenLight.next()
// ovenLight 现在等于 .Off
//上面的例子中定义了一个三态开关的枚举。每次调用 next 方法时,开关在不同的电源状态( Off , Low ,High )之前循环切换。


//类型方法 (Type Methods)
//也可以定义类型本身调用的方法,这种方法就叫做类型方法。声明 结构体和枚举的类型方法,在方法的 func 关键字之前加上关键字 static 。类可能会用关键字 class 来允许子类 重写父类的实现方法。
//注意:
//在 Objective-C 里面,你只能为 Objective-C 的类定义类型方法(type-level methods)。在 Swift 中,你 可以为所有的类、结构体和枚举定义类型方法:每一个类型方法都被它所支持的类型显式包含。

class MySomeClass {
    class func someTypeMethod() {
        // type method implementation goes here 
        print("Type Method Invoked")
    }
}
MySomeClass.someTypeMethod()
//在类型方法的方法体(body)中, self 指向这个类型本身,而不是类型的某个实例。对于结构体和枚举来 说,这意味着你可以用 self 来消除静态属性和静态方法参数之间的歧义(类似于我们在前面处理实例属性和实例 方法参数时做的那样)。





//一般来说,任何未限定的方法和属性名称,将会来自于本类中另外的类型级别的方法和属性。一个类型方法可以调用本类中另一个类型方法的名称,而无需在方法名称前面加上类型名称的前缀。同样,结构体和枚举的类型方法也能够直接通过静态属性的名称访问静态属性,而不需要类型名称前缀。

/**
*  下面的例子定义了一个名为 LevelTracker 结构体。它监测玩家的游戏发展情况(游戏的不同层次或阶段)。这是一个单人游戏,但也可以存储多个玩家在同一设备上的游戏信息。
游戏初始时,所有的游戏等级(除了等级 1)都被锁定。每次有玩家完成一个等级,这个等级就对这个设备上的所 有玩家解锁。 LevelTracker 结构体用静态属性和方法监测游戏的哪个等级已经被解锁。它还监测每个玩家的当 前等级。
*/


struct LevelTracker {
    static var highestUnlockedLevel = 1
    static func unlockLevel(level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level }
    }
    static func levelIsUnlocked(level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    var currentLevel = 1
    mutating func advanceToLevel(level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}
//LevelTracker 监测玩家的已解锁的最高等级。这个值被存储在静态属性 highestUnlockedLevel 中。
//LevelTracker 还定义了两个类型方法与 highestUnlockedLevel 配合工作。第一个类型方法是 unlockLevel :一旦新等级被解锁,它会更新 highestUnlockedLevel 的值。第二个类型方法是 levelIsUnlocked :如果某个 给定的等级已经被解锁,它将返回 true 。(注意:尽管我们没有使用类似 LevelTracker.highestUnlockedLeve l 的写法,这个类型方法还是能够访问静态属性 highestUnlockedLevel )
//除了静态属性和类型方法, LevelTracker 还监测每个玩家的进度。它用实例属性 currentLevel 来监测玩家当前 的等级。
//为了便于管理 currentLevel 属性, LevelTracker 定义了实例方法 advanceToLevel 。这个方法会在更新 curre ntLevel 之前检查所请求的新等级是否已经解锁。 advanceToLevel 方法返回布尔值以指示是否能够设置 curren tLevel 。

//下面, Player 类使用 LevelTracker 来监测和更新每个玩家的发展进度:
class Player {
    var tracker = LevelTracker()
    let playerName: String
    func completedLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1) }
    init(name: String) {
        playerName = name
    }
}
//Player 类创建一个新的 LevelTracker 实例来监测这个用户的进度。它提供了 completedLevel 方法:一旦玩家 完成某个指定等级就调用它。这个方法为所有玩家解锁下一等级,并且将当前玩家的进度更新为下一等级。(我 们忽略了 advanceToLevel 返回的布尔值,因为之前调用 LevelTracker.unlockLevel 时就知道了这个等级已经 被解锁了)。

//你还可以为一个新的玩家创建一个 Player 的实例,然后看这个玩家完成等级一时发生了什么:
var player = Player(name: "Argyrios")
player.completedLevel(3)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
if player.tracker.advanceToLevel(4) {
    print("player is now on level 4") }
else {
    print("level 4 has not yet been unlocked")
}

//如果你创建了第二个玩家,并尝试让他开始一个没有被任何玩家解锁的等级,那么这次设置玩家当前等级的尝试将会失败:
player = Player(name: "Beto")
if player.tracker.advanceToLevel(5) {
    print("player is now on level 5") }
else {
    print("level 5 has not yet been unlocked")
}
