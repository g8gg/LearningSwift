//: Playground - noun: a place where people can play

import Cocoa
//集合类型 (Collection Types)

//集合的可变性(Mutability of Collections)
/* 
    Swift 语言提供Arrays、Sets和Dictionarires三种基本的集合类型用来存储集合数据。
    数组是有序数据的集。集合是无序无重复数据的集。字典是无序的键值对的集。
*/

/*
    注意:
    在我们不需要改变集合大小的时候创建不可变集合是很好的习惯。
    如此 Swift 编译器可以优化我们创建的集合。
*/

//数组(Arrays)
//数组使用有序列表存储同一类型的多个值。相同的值可以多次出现在一个数组的不同位置中。
var someInts = [Int]()
print("someInts is of type [Int] with \(someInts.count) items.")
someInts.append(3)
someInts=[]
var threeDoubles = [Double](count: 3, repeatedValue:0.0)
var anotherThreeDoubles = Array(count: 3, repeatedValue: 2.5) //推断类型
threeDoubles = threeDoubles + anotherThreeDoubles
print(threeDoubles)
var shoppingList: [String] = ["Eggs", "Milk"]
var s1 = [String]()
s1=["1","2","3"]
var s2 = ["a","b","c"]

if shoppingList.isEmpty {//shoppingList.count==0
    print("The shopping list is empty.")
} else {
    print("The shopping list is not empty.")
}
shoppingList.append("Flour")
shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
shoppingList[0] = "Six eggs"
print(shoppingList)
shoppingList[2...6] = ["Bananas", "Apples"]
print(shoppingList)
shoppingList.insert("Maple Syrup", atIndex: 0)
let mapleSyrup = shoppingList.removeAtIndex(0)
print(mapleSyrup)
print(shoppingList)
let apples = shoppingList.removeLast()
print(shoppingList)
for item in shoppingList {
    print(item)
}
for (index, value) in shoppingList.enumerate() {
    print("Item \(String(index + 1)): \(value)")
}



//集合 Set
/*
    集合(Set)用来存储相同类型并且没有确定顺序的值。当集合元素顺序不重要时或者希望确保每个元素只出现一次 时可以使用集合而不是数组。
    Swift的 类型被桥接到Fundation中的NSSet类
*/
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")
/*
    注意:
    通过构造器,这里的 letters 变量的类型被推断为 Set<Character>
*/
letters.insert("a")
letters = []
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
var favoriteGenres1: Set = ["Rock", "Classical", "Hip hop"] //类型推断
if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}
favoriteGenres.insert("Jazz")
favoriteGenres.insert("Jazz")//Hash unique
if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
} else {
    print("I never much cared for that.")
}
print(favoriteGenres)
if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}
for genre in favoriteGenres {
    print("\(genre)")
}
for genre in favoriteGenres.sort() {//根据提供的序列返回一个有序集合
    print("\(genre)")
}

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
oddDigits.union(evenDigits).sort()
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] 
oddDigits.intersect(evenDigits).sort()
// []
oddDigits.subtract(singleDigitPrimeNumbers).sort()
// [1, 9] 
oddDigits.exclusiveOr(singleDigitPrimeNumbers).sort() // [1, 2, 9]


let houseAnimals: Set = ["a", "b"]
let farmAnimals: Set = ["a", "b", "c", "d", "e"]
let cityAnimals: Set = ["f", "g"]
houseAnimals.isSubsetOf(farmAnimals)// true
farmAnimals.isSupersetOf(houseAnimals) // true 
farmAnimals.isDisjointWith(cityAnimals)// true


//字典  Dictionary
//字典是一种存储多个相同类型的值的容器。每个值(value)都关联唯一的键(key),键作为字典中的这个值数 据的标识符。和数组中的数据项不同,字典中的数据项并没有具体顺序。我们在需要通过标识符(键)访问数据 的时候使用字典,这种方法很大程度上和我们在现实世界中使用字典查字义的方法一样。
/*
    Swift 的 Dictionary 类型被桥接到 Foundation 的 NSDictionary 类。
*/
var namesOfIntegers = [Int: String]()
namesOfIntegers[16] = "sixteen"
// namesOfIntegers 现在包含一个键值对 
namesOfIntegers = [:]
// namesOfIntegers 又成为了一个 [Int: String] 类型的空字典
var integersOfNames = [String: Int]()
integersOfNames["majun"]=30
integersOfNames["马骏"]=28
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
//var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"] 类型推导
print("The dictionary of airports contains \(airports.count) items.")
if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary is not empty.")
}

airports["LHR"] = "London"
airports["LHR"] = "London Heathrow"
print(airports)
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}
print(airports)
if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport is not in the airports dictionary.")
}
airports["APL"] = "Apple Internation"// "Apple Internation" 不是真的 APL 机场, 删除它 
print(airports)
airports["APL"] = nil // APL 现在被移除了
print(airports)
if let removedValue = airports.removeValueForKey("DUB") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}

//字典遍历
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}
for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}
for airportName in airports.values {
    print("Airport name: \(airportName)")
}

let airportCodes = [String](airports.keys)
let airportNames = [String](airports.values)

//Swift 的字典类型是无序集合类型。为了以特定的顺序遍历字典的键或值,可以对字典的 keys 或 values 属性使 用 sort() 方法。








