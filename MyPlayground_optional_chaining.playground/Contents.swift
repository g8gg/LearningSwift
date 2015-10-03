//: Playground - noun: a place where people can play

import Cocoa

//可选链式调用 Optional Chaining
//可选链式调用（Optional Chaining）是一种可以请求和调用属性、方法及下标的过程，它的可选性体现于请求或调用的目标当前可能为空（nil）。
//如果可空的目标有值，那么调用就会成功；如果选择的目标为空（nil），那么这种调用将返回空（nil）。多个连续的调用可以被链接在一起形成一个调用链，如果其中任何一个节点为空（nil）将导致整个链调用失败。
//注意： Swift 的可空链式调用和 Objective-C 中的消息为空有些相像，但是 Swift 可以使用在任意类型中，并且能够检查调用是否成功。


//使用可空链式调用来强制展开
//通过在想调用非空的属性、方法、或下标的可空值（optional value）后面放一个问号，可以定义一个可空链。这一点很像在可空值后面放一个叹号（！）来强制展开其中值。它们的主要的区别在于当可空值为空时可空链式只是调用失败，然而强制展开将会触发运行时错误。
//为了反映可空链式调用可以在空对象（nil）上调用，不论这个调用的属性、方法、下标等返回的值是不是可空值，它的返回结果都是一个可空值。你可以利用这个返回值来判断你的可空链式调用是否调用成功，如果调用有返回值则说明调用成功，返回nil则说明调用失败。
//特别地，可空链式调用的返回结果与原本的返回结果具有相同的类型，但是被包装成了一个可空类型值。当可空链式调用成功时，一个本应该返回Int的类型的结果将会返回Int?类型。
class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()
//let roomCount = john.residence!.numberOfRooms //如果使用叹号（！）强制展开获得这个john的residence属性中的numberOfRooms值，会触发运行时错误，因为这时没有可以展开的residence：
// this triggers a runtime error

//可空链式调用提供了一种另一种访问numberOfRooms的方法，使用问号（？）来代替原来叹号（！）的位置：
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
//在residence后面添加问号之后，Swift就会在residence不为空的情况下访问numberOfRooms。
//因为访问numberOfRooms有可能失败，可空链式调用会返回Int?类型，或称为“可空的Int”。如上例所示，当residence为nil的时候，可空的Int将会为nil，表明无法访问numberOfRooms。
//要注意的是，即使numberOfRooms是不可空的Int时，这一点也成立。只要是通过可空链式调用就意味着最后numberOfRooms返回一个Int?而不是Int。

//通过赋给john.residence一个Residence的实例变量：
john.residence = Residence()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}




//为可空链式调用定义模型类
//通过使用可空链式调用可以调用多层属性，方法，和下标。这样可以通过各种模型向下访问各种子属性。并且判断能否访问子属性的属性，方法或下标。


//下面这段代码定义了四个模型类，这些例子包括多层可空链式调用。为了方便说明，在Person和Residence的基础上增加了Room和Address，以及相关的属性，方法以及下标。
class PersonNew {
    var residence: ResidenceNew?
}

class ResidenceNew {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil {
            return buildingNumber
        } else {
            return nil
        }
    }
}


//通过可空链式调用访问属性
let gosber = PersonNew()
if let roomCount = gosber.residence?.numberOfRooms {
    print("Gosber's residence has \(roomCount) room(s).")
} else {
    print("Gosber: Unable to retrieve the number of rooms.")
}

//通过可空链式调用来设定属性值：
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
gosber.residence?.address = someAddress

//通过可空链式调用来调用方法
//如果在可空值上通过可空链式调用来调用这个方法，这个方法的返回类型为Void?，而不是Void，因为通过可空链式调用得到的返回值都是可空的。这样我们就可以使用if语句来判断能否成功调用printNumberOfRooms()方法，即使方法本身没有定义返回值。通过返回值是否为nil可以判断调用是否成功：

if gosber.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

//同样的，可以判断通过可空链式调用来给属性赋值是否成功。在上面的例子中，我们尝试给gosber.residence中的address属性赋值，即使residence为nil。通过可空链式调用给属性赋值会返回Void?，通过判断返回值是否为nil可以知道赋值是否成功：
if (gosber.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}

//通过可空链式调用来访问下标
//通过可空链式调用，我们可以用下标来对可空值进行读取或写入，并且判断下标调用是否成功。
//注意： 当通过可空链式调用访问可空值的下标的时候，应该将问号放在下标方括号的前面而不是后面。可空链式调用的问号一般直接跟在可空表达式的后面。

//下面这个例子用下标访问gosber.residence中rooms数组中第一个房间的名称，因为gosber.residence为nil，所以下标调用毫无疑问失败了：
if let firstRoomName = gosber.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
gosber.residence?[0] = Room(name: "Bathroom")
//如果你创建一个Residence实例，添加一些Room实例并赋值给gosber.residence，那就可以通过可选链和下标来访问数组中的元素：

let johnsHouse = ResidenceNew()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
gosber.residence = johnsHouse

if let firstRoomName = gosber.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}



//访问可空类型的下标：
//如果下标返回可空类型值，比如Swift中Dictionary的key下标。可以在下标的闭合括号后面放一个问号来链接下标的可空返回值：
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0]++
testScores["Brian"]?[0] = 72
// the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]
//key“Brian”在字典中不存在，所以第三个调用失败。



//多层链接
/**
*  可以通过多个链接多个可空链式调用来向下访问属性，方法以及下标。但是多层可空链式调用不会添加返回值的可空性。

也就是说：

如果你访问的值不是可空的，通过可空链式调用将会放回可空值。
如果你访问的值已经是可空的，通过可空链式调用不会变得“更”可空。
因此：

通过可空链式调用访问一个Int值，将会返回Int?，不过进行了多少次可空链式调用。
类似的，通过可空链式调用访问Int?值，并不会变得更加可空。
*/


//下面的例子访问gosber中的residence中的address中的street属性。这里使用了两层可空链式调用，residence以及address，这两个都是可空值。

if let johnsStreet = gosber.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
//需要注意的是，上面的例子中，street的属性为String?。john.residence?.address?.street的返回值也依然是String?，即使已经进行了两次可空的链式调用。

//如果把gosber.residence.address指向一个实例，并且为address中的street属性赋值，我们就能过通过可空链式调用来访问street属性。

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
gosber.residence?.address = johnsAddress

if let johnsStreet = gosber.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}





/**
*  对返回可空值的函数进行链接
*/
//上面的例子说明了如何通过可空链式调用来获取可空属性值。我们还可以通过可空链式调用来调用返回可空值的方法，并且可以继续对可空值进行链接。
//在下面的例子中，通过可空链式调用来调用Address的buildingIdentifier()方法。这个方法返回String?类型。正如上面所说，通过可空链式调用的方法的最终返回值还是String?：
if let buildingIdentifier = gosber.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}
//如果要进一步对方法的返回值进行可空链式调用，在方法buildingIdentifier()的圆括号后面加上问号：
if let beginsWithThe =
    gosber.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
        if beginsWithThe {
            print("John's building identifier begins with \"The\".")
        } else {
            print("John's building identifier does not begin with \"The\".")
        }
}
//注意： 在上面的例子中在，在方法的圆括号后面加上问号是因为buildingIdentifier()的返回值是可空值，而不是方法本身是可空的。


