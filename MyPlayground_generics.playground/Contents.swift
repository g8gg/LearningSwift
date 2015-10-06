//: Playground - noun: a place where people can play

import Cocoa

//泛型（Generics）
//泛型代码可以让你写出根据自我需求定义、适用于任何类型的，灵活且可重用的函数和类型。它的可以让你避免重复的代码，用一种清晰和抽象的方式来表达代码的意图。
//泛型是 Swift 强大特征中的其中一个，许多 Swift 标准库是通过泛型代码构建出来的。事实上，泛型的使用贯穿了整本语言手册，只是你没有发现而已。例如，Swift 的数组和字典类型都是泛型集。你可以创建一个Int数组，也可创建一个String数组，或者甚至于可以是任何其他 Swift 的类型数据数组。同样的，你也可以创建存储任何指定类型的字典（dictionary），而且这些类型可以是没有限制的。


//泛型所解决的问题
//这里是一个标准的，非泛型函数swapTwoInts,用来交换两个Int值：
func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

//swapTwoInts(_:_:)函数是非常有用的，但是它只能交换Int值，如果你想要交换两个String或者Double，就不得不写更多的函数，如 swapTwoStrings和swapTwoDoubles(_:_:)，如同如下所示：
func swapTwoStrings(inout a: String, inout _ b: String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(inout a: Double, inout _ b: Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}
//swapTwoInts、 swapTwoStrings和swapTwoDoubles(_:_:)函数功能都是相同的，唯一不同之处就在于传入的变量类型不同，分别是Int、String和Double。
//但实际应用中通常需要一个用处更强大并且尽可能的考虑到更多的灵活性单个函数，可以用来交换两个任何类型值，很幸运的是，泛型代码帮你解决了这种问题。（一个这种泛型函数后面已经定义好了。）
//注意： 在所有三个函数中，a和b的类型是一样的。如果a和b不是相同的类型，那它们俩就不能互换值。Swift 是类型安全的语言，所以它不允许一个String类型的变量和一个Double类型的变量互相交换值。如果一定要做，Swift 将报编译错误。



/**
*  泛型函数
泛型函数可以工作于任何类型，这里是一个上面swapTwoInts(_:_:)函数的泛型版本，用于交换两个值：
*/
func swapTwoValues<T>(inout a: T, inout _ b: T) {
    let temporaryA = a
    a = b
    b = temporaryA
}
//swapTwoValues(_:_:)函数主体和swapTwoInts(_:_:)函数是一样的，它只在第一行稍微有那么一点点不同于swapTwoInts
//占位类型名没有提示T必须是什么类型，但是它提示了a和b必须是同一类型T，而不管T表示什么类型。只有swapTwoValues(_:_:)函数在每次调用时所传入的实际类型才能决定T所代表的类型。
//另外一个不同之处在于这个泛型函数名后面跟着的占位类型名字（T）是用尖括号括起来的（<T>）。这个尖括号告诉 Swift 那个T是swapTwoValues(_:_:)函数所定义的一个类型。因为T是一个占位命名类型，Swift 不会去查找命名为T的实际类型。
swapTwoValues(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
print("someInt is now \(someString), and anotherInt is now \(anotherString)")
//注意 上面定义的函数swapTwoValues(_:_:)是受swap函数启发而实现的。swap函数存在于 Swift 标准库，并可以在其它类中任意使用。如果你在自己代码中需要类似swapTwoValues(_:_:)函数的功能，你可以使用已存在的交换函数swap(_:_:)函数。





//类型参数
//在上面的swapTwoValues例子中，占位类型T是一种类型参数的示例。类型参数指定并命名为一个占位类型，并且紧随在函数名后面，使用一对尖括号括起来（如<T>）。

//一旦一个类型参数被指定，那么其可以被使用来定义一个函数的参数类型（如swapTwoValues(_:_:)函数中的参数a和b），或作为一个函数返回类型，或用作函数主体中的注释类型。在这种情况下，被类型参数所代表的占位类型不管函数任何时候被调用，都会被实际类型所替换（在上面swapTwoValues例子中，当函数第一次被调用时，T被Int替换，第二次调用时，被String替换。）。
//你可支持多个类型参数，命名在尖括号中，用逗号分开。


//命名类型参数
//在简单的情况下，泛型函数或泛型类型需要指定一个占位类型（如上面的swapTwoValues泛型函数，或一个存储单一类型的泛型集，如数组），通常用一单个字母T来命名类型参数。不过，你可以使用任何有效的标识符来作为类型参数名。
//如果你使用多个参数定义更复杂的泛型函数或泛型类型，那么使用更多的描述类型参数是非常有用的。例如，Swift 字典（Dictionary）类型有两个类型参数，一个是键，另外一个是值。如果你自己写字典，你或许会定义这两个类型参数为Key和Value，用来记住它们在你的泛型代码中的作用。
//注意 请始终使用大写字母开头的驼峰式命名法（例如T和Key）来给类型参数命名，以表明它们是类型的占位符，而非类型值。


//泛型类型
//通常在泛型函数中，Swift 允许你定义你自己的泛型类型。这些自定义类、结构体和枚举作用于任何类型，如同Array和Dictionary的用法。
//这部分向你展示如何写一个泛型集类型--Stack（栈）。一个栈是一系列值域的集合，和Array（数组）类似，但其是一个比 Swift 的Array类型更多限制的集合。一个数组可以允许其里面任何位置的插入/删除操作，而栈，只允许在集合的末端添加新的项（如同push一个新值进栈）。同样的一个栈也只能从末端移除项（如同pop一个值出栈）。
//注意 栈的概念已被UINavigationController类使用来模拟试图控制器的导航结构。你通过调用UINavigationController的pushViewController(_:animated:)方法来为导航栈添加（add）新的试图控制器；而通过popViewControllerAnimated(_:)的方法来从导航栈中移除（pop）某个试图控制器。每当你需要一个严格的后进先出方式来管理集合，堆栈都是最实用的模型。


//这里展示了如何写一个非泛型版本的栈，Int值型的栈：
struct IntStack {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

//这个结构体在栈中使用一个Array性质的items存储值。Stack提供两个方法：push和pop，从栈中压进一个值和移除一个值。这些方法标记为可变的，因为它们需要修改（或转换）结构体的items数组。
//上面所展现的IntStack类型只能用于Int值，不过，其对于定义一个泛型Stack类（可以处理任何类型值的栈）是非常有用的。

//这里是一个相同代码的泛型版本：
struct Stack<T> {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
}
//注意到Stack的泛型版本基本上和非泛型版本相同，但是泛型版本的占位类型参数为T代替了实际Int类型。这种类型参数包含在一对尖括号里（<T>），紧随在结构体名字后面。

//T定义了一个名为“某种类型T”的节点提供给后来用。这种将来类型可以在结构体的定义里任何地方表示为“T”。在这种情况下，T在如下三个地方被用作节点：
//1.创建一个名为items的属性，使用空的T类型值数组对其进行初始化；
//2.指定一个包含一个参数名为item的push(_:)方法，该参数必须是T类型；
//3.指定一个pop方法的返回值，该返回值将是一个T类型值。
//由于Stack是泛型类型，所以在 Swift 中其可以用来创建任何有效类型的栈，这种方式如同Array和Dictionary。

//你可以通过在尖括号里写出栈中需要存储的数据类型来创建并初始化一个Stack实例。比如，要创建一个strings的栈，你可以写成Stack<String>()：
var stackOfStrings =  Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
print(stackOfStrings)
let fromTheTop = stackOfStrings.pop()
print(stackOfStrings)


//扩展一个泛型类型
//当你扩展一个泛型类型的时候，你并不需要在扩展的定义中提供类型参数列表。更加方便的是，原始类型定义中声明的类型参数列表在扩展里是可以使用的，并且这些来自原始类型中的参数名称会被用作原始定义中类型参数的引用。


//下面的例子扩展了泛型Stack类型，为其添加了一个名为topItem的只读计算属性，它将会返回当前栈顶端的元素而不会将其从栈中移除。
extension Stack {
    var topItem: T? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
    var bottomItem: T?{
        return items.isEmpty ? nil : items[0]
    }
    
    
}//topItem属性会返回一个T类型的可选值。当栈为空的时候，topItem将会返回nil；当栈不为空的时候，topItem会返回items数组中的最后一个元素。

//注意这里的扩展并没有定义一个类型参数列表。相反的，Stack类型已有的类型参数名称，T，被用在扩展中当做topItem计算属性的可选类型。
//topItem计算属性现在可以被用来返回任意Stack实例的顶端元素而无需移除它：
if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}
if let bottomItem = stackOfStrings.bottomItem {
    print("The top item on the stack is \(bottomItem).")
}





/**
*  类型约束
*/
//swapTwoValues(_:_:)函数和Stack类型可以作用于任何类型，不过，有的时候对使用在泛型函数和泛型类型上的类型强制约束为某种特定类型是非常有用的。类型约束指定了一个必须继承自指定类的类型参数，或者遵循一个特定的协议或协议构成。
//例如，Swift 的Dictionary类型对作用于其键的类型做了些限制。在字典的描述中，字典的键类型必须是可哈希，也就是说，必须有一种方法可以使其被唯一的表示。Dictionary之所以需要其键是可哈希是为了以便于其检查其是否已经包含某个特定键的值。如无此需求，Dictionary既不会告诉是否插入或者替换了某个特定键的值，也不能查找到已经存储在字典里面的给定键值。
//这个需求强制加上一个类型约束作用于Dictionary的键上，当然其键类型必须遵循Hashable协议（Swift 标准库中定义的一个特定协议）。所有的 Swift 基本类型（如String，Int， Double和 Bool）默认都是可哈希。
//当你创建自定义泛型类型时，你可以定义你自己的类型约束，当然，这些约束要支持泛型编程的强力特征中的多数。抽象概念如可哈希具有的类型特征是根据它们概念特征来界定的，而不是它们的直接类型特征。

//类型约束语法
//你可以写一个在一个类型参数名后面的类型约束，通过冒号分割，来作为类型参数链的一部分。这种作用于泛型函数的类型约束的基础语法如下所示（和泛型类型的语法相同）：
/*
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // 这里是函数主体
}
上面这个假定函数有两个类型参数。第一个类型参数T，有一个需要T必须是SomeClass子类的类型约束；第二个类型参数U，有一个需要U必须遵循SomeProtocol协议的类型约束。
*/


//类型约束行为
//这里有个名为findStringIndex的非泛型函数，该函数功能是去查找包含一给定String值的数组。若查找到匹配的字符串，findStringIndex(_:_:)函数返回该字符串在数组中的索引值（Int），反之则返回nil：
func findStringIndex(array: [String], _ valueToFind: String) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findStringIndex(strings, "llama") {
    print("The index of llama is \(foundIndex)")
}
//如果只是针对字符串而言查找在数组中的某个值的索引，用处不是很大，不过，你可以写出相同功能的泛型函数findIndex，用某个类型T值替换掉提到的字符串。

//这里展示如何写一个你或许期望的findStringIndex的泛型版本findIndex。请注意这个函数仍然返回Int，是不是有点迷惑呢，而不是泛型类型?那是因为函数返回的是一个可选的索引数，而不是从数组中得到的一个可选值。需要提醒的是，这个函数不会编译，原因在例子后面会说明：

/*func findIndex<T>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
*/

//上面所写的函数不会编译。这个问题的位置在等式的检查上，“if value == valueToFind”。不是所有的 Swift 中的类型都可以用等式符（==）进行比较。例如，如果你创建一个你自己的类或结构体来表示一个复杂的数据模型，那么 Swift 没法猜到对于这个类或结构体而言“等于”的意思。正因如此，这部分代码不能可能保证工作于每个可能的类型T，当你试图编译这部分代码时估计会出现相应的错误。
//不过，所有的这些并不会让我们无从下手。Swift 标准库中定义了一个Equatable协议，该协议要求任何遵循的类型实现等式符（==）和不等符（!=）对任何两个该类型进行比较。所有的 Swift 标准类型自动支持Equatable协议。

//任何Equatable类型都可以安全的使用在findIndex(_:_:)函数中，因为其保证支持等式操作。为了说明这个事实，当你定义一个函数时，你可以写一个Equatable类型约束作为类型参数定义的一部分：

func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}//findIndex中这个单个类型参数写做：T: Equatable，也就意味着“任何T类型都遵循Equatable协议”。
let doubleIndex = findIndex([3.14159, 0.1, 0.25], 9.3)
let stringIndex = findIndex(["Mike", "Malcolm", "Andrea"], "Andrea")


/**
*  关联类型(Associated Types)
当定义一个协议时，有的时候声明一个或多个关联类型作为协议定义的一部分是非常有用的。一个关联类型作为协议的一部分，给定了类型的一个占位名（或别名）。作用于关联类型上实际类型在协议被实现前是不需要指定的。关联类型被指定为typealias关键字。
*/


//关联类型行为
//这里是一个Container协议的例子，定义了一个ItemType关联类型：
protocol Container {
    typealias ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}
//Container协议定义了三个任何容器必须支持的兼容要求：
//1.必须可以通过append(_:)方法添加一个新元素到容器里；
//2.必须可以通过使用count属性获取容器里元素的数量，并返回一个Int值；
//3.必须可以通过容器的Int索引值下标可以检索到每一个元素。
//这个协议没有指定容器里的元素是如何存储的或何种类型是允许的。这个协议只指定三个任何遵循Container类型所必须支持的功能点。一个遵循的类型在满足这三个条件的情况下也可以提供其他额外的功能。
//任何遵循Container协议的类型必须指定存储在其里面的值类型，必须保证只有正确类型的元素可以加进容器里，必须明确可以通过其下标返回元素类型。
//为了定义这三个条件，Container协议需要一个方法指定容器里的元素将会保留，而不需要知道特定容器的类型。Container协议需要指定任何通过append(_:)方法添加到容器里的值和容器里元素是相同类型，并且通过容器下标返回的容器元素类型的值的类型是相同类型。
//为了达到此目的，Container协议声明了一个ItemType的关联类型，写作typealias ItemType。这个协议不会定义ItemType是什么的别名，这个信息将由任何遵循协议的类型来提供。尽管如此，ItemType别名提供了一种识别Container中元素类型的方法，并且用于append(_:)方法和subscript方法的类型定义，以便保证任何Container期望的行为能够被执行。
//这里是一个早前IntStack类型的非泛型版本，遵循Container协议：
struct IntStackNew: Container {
    // IntStackNew的原始实现
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // 遵循Container协议的实现
    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}
//IntStackNew类型实现了Container协议的所有三个要求，在IntStackNew类型的每个包含部分的功能都满足这些要求。
//此外，IntStackNew指定了Container的实现，适用的ItemType被用作Int类型。对于这个Container协议实现而言，定义 typealias ItemType = Int，将抽象的ItemType类型转换为具体的Int类型
//感谢Swift类型参考，你不用在IntStack定义部分声明一个具体的Int的ItemType。由于IntStack遵循Container协议的所有要求，只要通过简单的查找append(_:)方法的item参数类型和下标返回的类型，Swift就可以推断出合适的ItemType来使用。确实，如果上面的代码中你删除了 typealias ItemType = Int这一行，一切仍旧可以工作，因为它清楚的知道ItemType使用的是何种类型。
        
//你也可以生成遵循Container协议的泛型StackNew类型：
struct StackNew<T>: Container {
    // original Stack<T> implementation
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(item: T) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> T {
        return items[i]
    }
}//这个时候，占位类型参数T被用作append(_:)方法的item参数和下标的返回类型。Swift 因此可以推断出被用作这个特定容器的ItemType的T的合适类型。




//扩展一个存在的类型为一指定关联类型
//在在扩展中添加协议成员中有描述扩展一个存在的类型添加遵循一个协议。这个类型包含一个关联类型的协议。
//Swift的Array已经提供append(_:)方法，一个count属性和通过下标来查找一个自己的元素。这三个功能都达到Container协议的要求。也就意味着你可以扩展Array去遵循Container协议，只要通过简单声明Array适用于该协议而已。如何实践这样一个空扩展，在通过扩展补充协议声明中有描述这样一个实现一个空扩展的行为：
extension Array: Container {}
//如同上面的泛型StackNew类型一样，Array的append(_:)方法和下标保证Swift可以推断出ItemType所使用的适用的类型。定义了这个扩展后，你可以将任何Array当作Container来使用。

//Where 语句
//类型约束能够确保类型符合泛型函数或类的定义约束。

//下面的例子定义了一个名为allItemsMatch的泛型函数，用来检查两个Container实例是否包含相同顺序的相同元素。如果所有的元素能够匹配，那么返回一个为true的Boolean值，反之则为false。
//被检查的两个Container可以不是相同类型的容器（虽然它们可以是），但它们确实拥有相同类型的元素。这个需求通过一个类型约束和where语句结合来表示：
func allItemsMatch<
    C1: Container, C2: Container
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
    (someContainer: C1, anotherContainer: C2) -> Bool {
        
        // 检查两个Container的元素个数是否相同
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        // 检查两个Container相应位置的元素彼此是否相等
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        // 如果所有元素检查都相同则返回true
        return true
        
}
//这个函数用了两个参数：someContainer和anotherContainer。someContainer参数是类型C1，anotherContainer参数是类型C2。C1和C2是容器的两个占位类型参数，决定了这个函数何时被调用。
//这个函数的类型参数列紧随在两个类型参数需求的后面：
//1.C1必须遵循Container协议 (写作 C1: Container)。
//2.C2必须遵循Container协议 (写作 C2: Container)。
//3.C1的ItemType同样是C2的ItemType（写作 C1.ItemType == C2.ItemType）。
//4.C1的ItemType必须遵循Equatable协议 (写作 C1.ItemType: Equatable)。

//这里演示了allItemsMatch(_:_:)函数运算的过程：
var stackOfStringsNew = StackNew<String>()
stackOfStringsNew.push("uno")
stackOfStringsNew.push("dos")
stackOfStringsNew.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStringsNew, anotherContainer: arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}
//上面的例子创建一个Stack单例来存储String，然后压了三个字符串进栈。这个例子也创建了一个Array单例，并初始化包含三个同栈里一样的原始字符串。即便栈和数组是不同的类型，但它们都遵循Container协议，而且它们都包含同样的类型值。因此你可以调用allItemsMatch(_:_:)函数，用这两个容器作为它的参数。在上面的例子中，allItemsMatch(_:_:)函数正确的显示了这两个容器的所有元素都是相互匹配的。



