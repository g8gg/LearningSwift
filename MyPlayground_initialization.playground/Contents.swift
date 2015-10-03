//: Playground - noun: a place where people can play

import Cocoa

//构造过程 Initialization
//构造过程是为了使用某个类、结构体或枚举类型的实例而进行的准备过程。
//这个过程包含了为实例中的每个存储型属性设置初始值和为其执行必要的准备和初始化任务。
//构造过程是通过定义构造器( Initializers )来实现的,这些构造器可以看做是用来创建特定类型实例的特殊方法。
//与 Objective-C 中的构造器不同,Swift 的构造器无需返回值,它们的主要任务是保证新实例在第一次使用前完成正确的初始化。
//**析构过程** 类的实例也可以通过定义析构器( deinitializer )在实例释放之前执行特定的清除工作。
/**/


/**
*  存储型属性的初始赋值
*/
//类和结构体在实例创建时,必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态。
//你可以在构造器中为存储型属性赋初值,也可以在定义属性时为其设置默认值。
/**
*  注意: 
    当你为存储型属性设置默认值或者在构造器中为其赋值时,它们的值是被直接设置的,不会触发任何属性观测器(property observers)。
*/

//构造器
//构造器在创建某特定类型的新实例时调用。它的最简形式类似于一个不带任何参数的实例方法,以关键字 init 命 名。
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
//这个结构体定义了一个不带参数的构造器 init ,并在里面将存储型属性 temperature 的值初始化为 32.0 (华摄 氏度下水的冰点)。

//默认属性值
//注意:
//如果一个属性总是使用同一个初始值,可以为其设置一个默认值。无论定义默认值还是在构造器中赋值,最终它
//们实现的效果是一样的,只不过默认值将属性的初始化和属性的声明结合的更紧密。使用默认值能让你的构造器
//更简洁、更清晰,且能通过默认值自动推导出属性的类型;同时,它也能让你充分利用默认构造器、构造器继
//承等特性。

/**
*  你可以使用更简单的方式在定义结构体 Fahrenheit 时为属性 temperature 设置默认值:
struct Fahrenheit {
    var temperature = 32.0
}
*/

//自定义构造过程
//构造参数
//你可以在定义构造器时提供构造参数,为其提供自定义构造所需值的类型和名字。构造器参数的功能和语法跟函数和方法参数相同。
struct Celsius {
    var temperatureInCelsius: Double = 0.0
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
print(boilingPointOfWater.temperatureInCelsius)
print(freezingPointOfWater.temperatureInCelsius)


//参数的内部名称和外部名称
//跟函数和方法参数相同,构造参数也存在一个在构造器内部使用的参数名字和一个在调用构造器时使用的外部参数名字。
//然而,构造器并不像函数和方法那样在括号前有一个可辨别的名字。所以在调用构造器时,主要通过构造器中的 参数名和类型来确定需要调用的构造器。正因为参数如此重要,如果你在定义构造器时没有提供参数的外部名 字,Swift 会为每个构造器的参数自动生成一个跟内部名字相同的外部名,就相当于在每个构造参数之前加了一个 哈希符号。

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}


let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

//注意,如果不通过外部参数名字传值,你是没法调用这个构造器的。只要构造器定义了某个外部参数名,你就必须使用它,忽略它将导致编译错误:
//let veryGreen = Color(0.0, 1.0, 0.0)




//不带外部名的构造器参数
//如果你不希望为构造器的某个参数提供外部名字,你可以使用下划线(_)来显示描述它的外部名,以此重写上面所说的默认行为。
struct CelsiusNew {
    var temperatureInCelsius: Double = 0.0
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8 }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double){
        temperatureInCelsius = celsius }
}
let bodyTemperature = CelsiusNew(37.0)
//调用这种不需要外部参数名称的 Celsius(37.0) 构造器看起来十分简明的。因此适当使用这种 init(_ celsius: Dou ble) 构造器可以提供 Double 类型的参数值而不需要加上外部名。


//可选属性类型
//如果你定制的类型包含一个逻辑上允许取值为空的存储型属性
//--不管是因为它无法在初始化时赋值,还是因为它可以在之后某个时间点可以赋值为空
//--你都需要将它定义为可选类型optional type。可选类型的属性将自动初始化为空 nil ,表示这个属性是故意在初始化时设置为空的。
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese."
cheeseQuestion.text="test" //ok
//调查问题在问题提出之后,我们才能得到回答。所以我们将属性回答 response 声明为 String? 类型,或者说是 可选字符串类型 optional String 。当 SurveyQuestion 实例化时,它将自动赋值为空 nil ,表明暂时还不存在此 字符串。


//构造过程中常量属性的修改
//只要在构造过程结束前常量的值能确定,你可以在构造过程中的任意时间点修改常量属性的值。
//注意:
//对某个类实例来说,它的常量属性只能在定义它的类的构造过程中修改;不能在子类中修改。
//你可以修改上面的 SurveyQuestion 示例,用常量属性替代变量属性 text ,指明问题内容 text 在其创建之后不 会再被修改。尽管 text 属性现在是常量,我们仍然可以在其类的构造器中设置它的值:

class SurveyQuestionNew {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestionNew(text: "How about beets?")
beetsQuestion.ask()
beetsQuestion.response = "I also like beets. (But not with cheese.)"
//beetsQuestion.text="test" //error




//默认构造器
//Swift 将为所有属性已提供默认值的且自身没有定义任何构造器的结构体或基类,提供一个默认的构造器。这个默 认构造器将简单的创建一个所有属性值都设置为默认值的实例。
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()
//由于 ShoppingListItem 类中的所有属性都有默认值,且它是没有父类的基类,它将自动获得一个可以为所有属 性设置默认值的默认构造器(尽管代码中没有显式为 name 属性设置默认值,但由于 name 是可选字符串类 型,它将默认设置为 nil )。上面例子中使用默认构造器创造了一个 ShoppingListItem 类的实例(使用 Shoppi ngListItem() 形式的构造器语法),并将其赋值给变量 item 。



//结构体的逐一成员构造器
//如果结构体对所有存储型属性提供了默认值且自身没有提供定制的构造器,它们能自动获得一个逐一成员构造器。
//逐一成员构造器是用来初始化结构体新实例里成员属性的快捷方法。我们在调用逐一成员构造器时,通过与成员属性名相同的参数名进行传值来完成对成员属性的初始赋值
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)
//由于这两个存储型属性都有默认值,结构体 Size 自动获得了一个逐一成员构造器 init(width:height:) 。 



//值类型的构造器代理
//构造器可以通过调用其它构造器来完成实例的部分构造过程。这一过程称为构造器代理,它能减少多个构造器间的代码重复。
//构造器代理的实现规则和形式在值类型和类类型中有所不同。值类型(结构体和枚举类型)不支持继承,所以构 造器代理的过程相对简单,因为它们只能代理给本身提供的其它构造器。
//类则不同,它可以继承自其它类(请参考继承),这意味着类有责任保证其所有继承的存储型属性在构造时也能正确的初始化。
//对于值类型,你可以使用 self.init 在自定义的构造器中引用其它的属于相同值类型的构造器。并且你只能在构造 器内部调用 self.init 。
//如果你为某个值类型定义了一个定制的构造器,你将无法访问到默认构造器(如果是结构体,则无法访问逐一对象构造器)。这个限制可以防止你在为值类型定义了一个更复杂的,完成了重要准备构造器之后,别人还是错误的使用了那个自动生成的构造器。
//注意: 假如你想通过默认构造器、逐一对象构造器以及你自己定制的构造器为值类型创建实例,我们建议你将自己定制 的构造器写到扩展( extension )中,而不是跟值类型定义混在一起。
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
//第一个 Rect 构造器 init() ,在功能上跟没有自定义构造器时自动获得的默认构造器是一样的。这个构造器是一个 空函数,使用一对大括号 {} 来描述,它没有执行任何定制的构造过程。调用这个构造器将返回一个 Rect 实 例,它的 origin 和 size 属性都使用定义时的默认值 Point(x: 0.0, y: 0.0) 和 Size(width: 0.0, height: 0.0)
let basicRect = Rect()
// basicRect 的原点是 (0.0, 0.0),尺寸是 (0.0, 0.0)
print(basicRect)
//第二个 Rect 构造器 init(origin:size:) ,在功能上跟结构体在没有自定义构造器时获得的逐一成员构造器是一样 的。这个构造器只是简单地将 origin 和 size 的参数值赋给对应的存储型属性:
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
// originRect 的原点是 (2.0, 2.0),尺寸是 (5.0, 5.0)
print(originRect)

//第三个 Rect 构造器 init(center:size:) 稍微复杂一点。它先通过 center 和 size 的值计算出 origin 的坐标。然后再调用(或代理给) init(origin:size:) 构造器来将新的 origin 和 size 值赋值到对应的属性中:
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
print(centerRect)
// centerRect 的原点是 (2.5, 2.5),尺寸是 (3.0, 3.0)
//构造器 init(center:size:) 可以自己将 origin 和 size 的新值赋值到对应的属性中。然而尽量利用现有的构造器和它所提供的功能来实现 init(center:size:) 的功能,是更方便、更清晰和更直观的方法。

/**
*  注意:
如果你想用另外一种不需要自己定义 init() 和 init(origin:size:) 的方式来实现这个例子,请参考扩展。
*/




//类的继承和构造过程
//类里面的所有存储型属性--包括所有继承自父类的属性--都必须在构造过程中设置初始值。
//Swift 提供了两种类型的类构造器来确保所有类实例中存储型属性都能获得初始值,它们分别是指定构造器和便利构造器。

//指定构造器和便利构造器
//指定构造器是类中最主要的构造器。一个指定构造器将初始化类中提供的所有属性,并根据父类链往上调用父类的构造器来实现父类的初始化。
//每一个类都必须拥有至少一个指定构造器。在某些情况下,许多类通过继承了父类中的指定构造器而满足了这个条件。
//便利构造器是类中比较次要的、辅助型的构造器。你可以定义便利构造器来调用同一个类中的指定构造器,并为其参数提供默认值。你也可以定义便利构造器来创建一个特殊用途或特定输入的实例。
//你应当只在必要的时候为类提供便利构造器,比方说某种情况下通过使用便利构造器来快捷调用某个指定构造器,能够节省更多开发时间并让类的构造过程更清晰明了。


//指定构造器和便利构造器的语法(convenience)
/**
*  类的指定构造器的写法跟值类型简单构造器一样:
init(parameters) { statements
}
便利构造器也采用相同样式的写法,但需要在 init 关键字之前放置 convenience 关键字,并使用空格将它们俩分 开:
convenience init(parameters) { statements
}
*/

/**
*  类的构造器代理规则
   为了简化指定构造器和便利构造器之间的调用关系,Swift 采用以下三条规则来限制构造器之间的代理调用:
    规则 1 指定构造器必须调用其直接父类的的指定构造器。
    规则 2 便利构造器必须调用同一类中定义的其它构造器。
    规则 3 便利构造器必须最终以调用一个指定构造器结束。
一个更方便记忆的方法是:
    1. 指定构造器必须总是向上代理
    2. 便利构造器必须总是横向代理
注意:
这些规则不会影响使用时,如何用类去创建实例。
任何上图中展示的构造器都可以用来完整创建对应类的实例。这些规则只在实现类的定义时有影响。
*/

//两段式构造过程
//Swift 中类的构造过程包含两个阶段。第一个阶段,每个存储型属性通过引入它们的类的构造器来设置初始值。当 每一个存储型属性值被确定后,第二阶段开始,它给每个类一次机会在新实例准备使用之前进一步定制它们的存 储型属性。
//两段式构造过程的使用让构造过程更安全,同时在整个类层级结构中给予了每个类完全的灵活性。两段式构造过程可以防止属性值在初始化之前被访问;也可以防止属性被另外一个构造器意外地赋予不同的值。
//注意:
//Swift的两段式构造过程跟 Objective-C 中的构造过程类似。最主要的区别在于阶段 1,Objective-C 给每一 个属性赋值 0 或空值(比如说 0 或 nil )。Swift 的构造流程则更加灵活,它允许你设置定制的初始值,并自 如应对某些属性不能以 0 或 nil 作为合法默认值的情况。
//Swift 编译器将执行 4 种有效的安全检查,以确保两段式构造过程能顺利完成:
//安全检查 1 指定构造器必须保证它所在类引入的所有属性都必须先初始化完成,之后才能将其它构造任务向上代理给父类中 的构造器。
//如上所述,一个对象的内存只有在其所有存储型属性确定之后才能完全初始化。为了满足这一规则,指定构造器
//必须保证它所在类引入的属性在它往上代理之前先完成初始化。
//安全检查 2 指定构造器必须先向上代理调用父类构造器,然后再为继承的属性设置新值。如果没这么做,指定构造器赋予的 新值将被父类中的构造器所覆盖。
//安全检查 3 便利构造器必须先代理调用同一类中的其它构造器,然后再为任意属性赋新值。如果没这么做,便利构造器赋予 的新值将被同一类中其它指定构造器所覆盖。
//安全检查 4
//构造器在第一阶段构造完成之前,不能调用任何实例方法、不能读取任何实例属性的值, self 的值不能被引用。
//类实例在第一阶段结束以前并不是完全有效,仅能访问属性和调用方法,一旦完成第一阶段,该实例才会声明为有效实例。
//以下是两段式构造过程中基于上述安全检查的构造流程展示:
//阶段 1
//某个指定构造器或便利构造器被调用;
//完成新实例内存的分配,但此时内存还没有被初始化;
//指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化;
//指定构造器将调用父类的构造器,完成父类属性的初始化;
//这个调用父类构造器的过程沿着构造器链一直往上执行,直到到达构造器链的最顶部;
//当到达了构造器链最顶部,且已确保所有实例包含的存储型属性都已经赋值,这个实例的内存被认为已经完 全初始化。此时阶段1完成。
//阶段 2
//从顶部构造器链一直往下,每个构造器链中类的指定构造器都有机会进一步定制实例。构造器此时可以访问 self 、修改它的属性并调用实例方法等等。
//最终,任意构造器链中的便利构造器可以有机会定制实例和使用 self 。
//具体参见：http://wiki.jikexueyuan.com/project/swift/chapter2/14_Initialization.html
//如安全检查1所示，指定构造器将确保所有子类的属性都有值。然后它将调用父类的指定构造器，并沿着造器链一直往上完成父类的构建过程。
//父类中的指定构造器确保所有父类的属性都有值。由于没有更多的父类需要构建，也就无需继续向上做构建代理。
//一旦父类中所有属性都有了初始值，实例的内存被认为是完全初始化，而阶段1也已完成。
//父类中的指定构造器现在有机会进一步来定制实例（尽管它没有这种必要）。
//一旦父类中的指定构造器完成调用，子类的构指定构造器可以执行更多的定制操作（同样，它也没有这种必要）。
//最终，一旦子类的指定构造器完成调用，最开始被调用的便利构造器可以执行更多的定制操作。





/**
*  构造器的继承和重写
*/
//跟Objective-C中的子类不同，Swift中的子类不会默认继承父类的构造器。Swift的这种机制可以防止一个父类的简单构造器被一个更专业的子类继承，并被错误的用来创建子类的实例。
//注意： 父类的构造器仅在确定和安全的情况下被继承。
//假如你希望自定义的子类中能实现一个或多个跟父类相同的构造器，也许是为了完成一些定制的构造过程，你可以在你定制的子类中提供和重写与父类相同的构造器。
//当你写一个父类中带有指定构造器的子类构造器时，你需要重写这个指定的构造器。因此，你必须在定义子类构造器时带上override修饰符。即使你重写系统提供的默认构造器也需要带上override修饰符
//无论是重写属性，方法或者是下标脚本，只要含有override修饰符就会去检查父类是否有相匹配的重写指定构造器和验证重写构造器参数。
//注意：当你重写一个父类指定构造器时，你需要写override修饰符，甚至你的子类构造器继承的是父类的便利构造器。
//相反地，如果你写了一个和父类便利构造器相匹配的子类构造器，子类都不能直接调用父类的便利构造器，每个规则都在上文构造器链有所描述。
class Vehicle {
    let numbrOfFrontLights=2
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}//Vehicle类只为存储型属性提供默认值，而不自定义构造器。
let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
//        numbrOfFrontLights=3//注意子类可以在初始化时修改继承变量属性,但是不能修改继承过来的常量属性。
    }
}//注意子类可以在初始化时修改继承变量属性,但是不能修改继承过来的常量属性。
//子类 Bicycle 定义了一个自定义指定构造器 init() 。
//这个指定构造器和父类的指定构造器相匹配,所以 Bicycle 中的指定构造器需要带上 override 修饰符。
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")
print(bicycle.numberOfWheels)
print(bicycle.numbrOfFrontLights)


//自动构造器的继承
//如上所述,子类不会默认继承父类的构造器。但是如果特定条件可以满足,父类构造器是可以被自动继承的。在实践中,这意味着对于许多常见场景你不必重写父类的构造器,并且在尽可能安全的情况下以最小的代价来继承父类的构造器。
//假设要为子类中引入的任意新属性提供默认值,请遵守以下2个规则:
//规则 1 如果子类没有定义任何指定构造器,它将自动继承所有父类的指定构造器。
//规则 2 如果子类提供了所有父类指定构造器的实现--不管是通过规则1继承过来的,还是通过自定义实现的--它将自动 继承所有父类的便利构造器。
//即使你在子类中添加了更多的便利构造器,这两条规则仍然适用。
//注意: 子类可以通过部分满足规则2的方式,使用子类便利构造器来实现父类的指定构造器。


//指定构造器和便利构造器操作
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }//类没有提供一个默认的逐一成员构造器,所以 Food 类提供了一个接受单一参数 name 的指定构造器。
}
let namedMeat = Food(name: "Bacon")// init(name: String) 被定义为一个指定构造器
// Food 类没有父类,所以 init(name: String) 构造器不需要调用 super.init() 来完成构造。

let mysteryMeat = Food()
//Food 类同样提供了一个没有参数的便利构造器 init() 。这个 init() 构造器为新食物提供了一个默认的占位名 字,通过代理调用同一类中定义的指定构造器 init(name: String) 并给参数 name 传值 [Unnamed] 来实现



class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
//类层级中的第二个类是 Food 的子类 RecipeIngredient 。 RecipeIngredient 类构建了食谱中的一味调味剂。它 引入了 Int 类型的数量属性 quantity (以及从 Food 继承过来的 name 属性),并且定义了两个构造器来创建RecipeIngredient 实例:

//RecipeIngredient 类拥有一个指定构造器 init(name: String, quantity: Int) ,它可以用来产生新 RecipeIngredie nt 实例的所有属性值。这个构造器一开始先将传入的 quantity 参数赋值给 quantity 属性,这个属性也是唯一在RecipeIngredient 中新引入的属性。随后,构造器将任务向上代理给父类 Food 的 init(name: String) 。这个过 程满足两段式构造过程中的安全检查1。
//RecipeIngredient也定义了一个便利构造器 ,它只通过来创建的实例。
//这个便利构造器假设任意 实例的 ￼ 为1,所以不需要显示指明数量即可创建出实例
//这个便利构造器的定义可以让创建实例更加方便和快捷,并且避免了使用重复的代码来创建多个 quantity 为 1 的 RecipeIngredient 实例。这个便利构造器只是简单的将任务代理给了同一类里提供的指定构造器。
//注意, RecipeIngredient 的便利构造器 init(name: String) 使用了跟 Food 中指定构造器 init(name: String) 相 同的参数。因为这个便利构造器重写要父类的指定构造器 init(name: String) ,必须在前面使用使用 override 标识

//在这个例子中，RecipeIngredient的父类是Food，它有一个便利构造器init()。这个构造器因此也被RecipeIngredient继承。这个继承的init()函数版本跟Food提供的版本是一样的，除了它是将任务代理给RecipeIngredient版本的init(name: String)而不是Food提供的版本。
//所有的这三种构造器都可以用来创建新的RecipeIngredient实例：
let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItemNew: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name.lowercaseString)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}
//注意：
//ShoppingListItemNew没有定义构造器来为purchased提供初始化值，这是因为任何添加到购物单的项的初始状态总是未购买。
//由于它为自己引入的所有属性都提供了默认值，并且自己没有定义任何构造器，ShoppingListItem将自动继承所有父类中的指定构造器和便利构造器。

var breakfastList = [
    ShoppingListItemNew(),
    ShoppingListItemNew(name: "Bacon"),
    ShoppingListItemNew(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}


/**
*  可失败构造器
*/
//如果一个类，结构体或枚举类型的对象，在构造自身的过程中有可能失败，则为其定义一个可失败构造器，是非常有必要的。这里所指的“失败”是指，如给构造器传入无效的参数值，或缺少某种所需的外部资源，又或是不满足某种必要的条件等。
//为了妥善处理这种构造过程中可能会失败的情况。你可以在一个类，结构体或是枚举类型的定义中，添加一个或多个可失败构造器。其语法为在init关键字后面加添问号(init?)。
//注意： 可失败构造器的参数名和参数类型，不能与其它非可失败构造器的参数名，及其类型相同。
//可失败构造器，在构建对象的过程中，创建一个其自身类型为可选类型的对象。你通过return nil 语句，来表明可失败构造器在何种情况下“失败”。
//注意： 严格来说，构造器都不支持返回值。因为构造器本身的作用，只是为了能确保对象自身能被正确构建。所以即使你在表明可失败构造器，失败的这种情况下，用到了return nil。也不要在表明可失败构造器成功的这种情况下，使用关键字 return。

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}

let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}
let anonymousCreature = Animal(species: "")
if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}


/**
*  枚举类型的可失败构造器
*/
//你可以通过构造一个带一个或多个参数的可失败构造器来获取枚举类型中特定的枚举成员。还能在参数不满足你所期望的条件时，导致构造失败。
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}

//带原始值的枚举类型的可失败构造器
//带原始值的枚举类型会自带一个可失败构造器init?(rawValue:),该可失败构造器有一个名为rawValue的默认参数,其类型和枚举类型的原始值类型一致，如果该参数的值能够和枚举类型成员所带的原始值匹配，则该构造器构造一个带此原始值的枚举成员，否则构造失败。
enum TemperatureUnitNew: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fahrenheitUnit1 = TemperatureUnitNew(rawValue: "F")
if fahrenheitUnit1 != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit1 = TemperatureUnitNew(rawValue: "X")
if unknownUnit1 == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}

/**
*  类的可失败构造器
*/
//值类型（如结构体或枚举类型）的可失败构造器，对何时何地触发构造失败这个行为没有任何的限制。
//类的可失败构造器只能在所有的类属性被初始化后和所有类之间的构造器之间的代理调用发生完后触发失败行为。
class Product {
    let name: String!
    init?(name: String) {
        self.name = name
        if name.isEmpty { return nil }
    }
}
if let bowTie = Product(name: "") {
    //因为name属性是一个常量，所以一旦Product类构造成功，name属性肯定有一个非nil的值。因此完全可以放心大胆的直接访问Product类的name属性，而不用考虑去检查name属性是否有值。
    // 不需要检查 bowTie.name == nil
    print("The product's name is \(bowTie.name)")
}
else
{
    print("init failed.")
}




//构造失败的传递
//可失败构造器同样满足在构造器链中所描述的构造规则。
//其允许在同一类，结构体和枚举中横向代理其他的可失败构造器。类似的，子类的可失败构造器也能向上代理基类的可失败构造器。
//无论是向上代理还是横向代理，如果你代理的可失败构造器，在构造过程中触发了构造失败的行为，整个构造过程都将被立即终止，接下来任何的构造代码都将不会被执行。
//注意： 可失败构造器也可以代理调用其它的非可失败构造器。通过这个方法，你可以为已有的构造过程加入构造失败的条件。
class CartItem: Product {
    var quantity: Int!
    init?(name: String, quantity: Int) {
        super.init(name: name)
        if quantity < 1 {
            return nil
        }
        self.quantity = quantity
    }
}
//和Product类中的name属性相类似的，CartItem类中的quantity属性的类型也是一个隐式解析可选类型，只不过由（String!）变为了（Int!）。这样做都是为了确保在构造过程中，该属性在被赋予特定的值之前能有一个默认的初始值nil。
//可失败构造器总是先向上代理调用基类,Product的构造器 init(name:)。这满足了可失败构造器在触发构造失败这个行为前必须总是执行构造代理调用这个条件。
//如果由于name的值为空而导致基类的构造器在构造过程中失败。则整个CartIem类的构造过程都将失败，后面的子类的构造过程都将不会被执行。
if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}

if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}
//类似的, 如果你构造一个CartItem对象，但其name的值为空, 则基类Product的可失败构造器将触发构造失败的行为，整个CartItem的构造行为同样为失败：
if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}




/**
*  重写一个可失败构造器
*/
//就如同其它构造器一样，你也可以用子类的可失败构造器重写基类的可失败构造器。或者你也可以用子类的非可失败构造器重写一个基类的可失败构造器。这样做的好处是，即使基类的构造器为可失败构造器，但当子类的构造器在构造过程不可能失败时，我们也可以把它修改过来。
//注意当你用一个子类的非可失败构造器重写了一个父类的可失败构造器时，子类的构造器将不再能向上代理父类的可失败构造器。一个非可失败的构造器永远也不能代理调用一个可失败构造器。
//注意： 你可以用一个非可失败构造器重写一个可失败构造器，但反过来却行不通。

//下例定义了一个名为Document的类，这个类中的name属性允许为nil和一个非空字符串，但不能是一个空字符串：

class Document {
    var name: String?
    // 该构造器构建了一个name属性值为nil的document对象
    init() {}
    // 该构造器构建了一个name属性值为非空字符串的document对象
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

//下面这个例子，定义了一个名为AutomaticallyNamedDocument的Document类的子类。这个子类重写了基类的两个指定构造器。确保了不论在何种情况下name属性总是有一个非空字符串[Untitled]的值。
class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}
//AutomaticallyNamedDocument用一个非可失败构造器init(name:),重写了基类的可失败构造器init?(name:)。因为子类用不同的方法处理了name属性的值为一个空字符串的这种情况。所以子类将不再需要一个可失败的构造器。


//可失败构造器 init!
//通常来说我们通过在init关键字后添加问号的方式来定义一个可失败构造器，但你也可以使用通过在init后面添加惊叹号的方式来定义一个可失败构造器(init!)，该可失败构造器将会构建一个特定类型的隐式解析可选类型的对象。
//你可以在 init?构造器中代理调用 init!构造器，反之亦然。 你也可以用 init?重写 init!，反之亦然。 你还可以用 init代理调用init!，但这会触发一个断言：是否 init! 构造器会触发构造失败？


//必要构造器
//在类的构造器前添加 required 修饰符表明所有该类的子类都必须实现该构造器：
class SomeClass {
    required init() {
        // 在这里添加该必要构造器的实现代码
    }
}

//当子类重写基类的必要构造器时，必须在子类的构造器前同样添加required修饰符以确保当其它类继承该子类时，该构造器同为必要构造器。在重写基类的必要构造器时，不需要添加override修饰符：
class SomeSubclass: SomeClass {
    required init() {
        // 在这里添加子类必要构造器的实现代码
    }
}
//注意： 如果子类继承的构造器能满足必要构造器的需求，则你无需显示的在子类中提供必要构造器的实现。




/**
*  通过闭包和函数来设置属性的默认值
*/
//如果某个存储型属性的默认值需要特别的定制或准备，你就可以使用闭包或全局函数来为其属性提供定制的默认值。每当某个属性所属的新类型实例创建时，对应的闭包或函数会被调用，而它们的返回值会当做默认值赋值给这个属性。
//这种类型的闭包或函数一般会创建一个跟属性类型相同的临时变量，然后修改它的值以满足预期的初始状态，最后将这个临时变量的值作为属性的默认值进行返回。

//下面列举了闭包如何提供默认值的代码概要：
class SomeClassNew {
    let someProperty: String = {//SomeType is String
        // 在这个闭包中给 someProperty 创建一个默认值
        // someValue 必须和 SomeType 类型相同
        return ""//someValue
        }()//注意闭包结尾的大括号后面接了一对空的小括号。这是用来告诉 Swift 需要立刻执行此闭包。如果你忽略了这对括号，相当于是将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性。
}
/**
*  注意：
如果你使用闭包来初始化属性的值，请记住在闭包执行时，实例的其它部分都还没有初始化。这意味着你不能够在闭包里访问其它的属性，就算这个属性有默认值也不允许。同样，你也不能使用隐式的self属性，或者调用其它的实例方法。
*/





/**
*  西洋跳棋游戏在一副黑白格交替的 10x10 的棋盘中进行。为了呈现这副游戏棋盘，Checkerboard结构体定义了一个属性boardColors，它是一个包含 100 个布尔值的数组。数组中的某元素布尔值为true表示对应的是一个黑格，布尔值为false表示对应的是一个白格。数组中第一个元素代表棋盘上左上角的格子，最后一个元素代表棋盘上右下角的格子。
boardColor数组是通过一个闭包来初始化和组装颜色值的：
*/
struct Checkerboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
        }()
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 10) + column]
    }
}
let board = Checkerboard()
print(board.squareIsBlackAtRow(0, column: 1))
print(board.squareIsBlackAtRow(9, column: 9))
