//: Playground - noun: a place where people can play

import Cocoa
/*
注意:
    Swift的String类型与Foundation NSString类进行了无缝桥接
    就像AnyObject类型中提到的一样,在使用Cocoa中的Foundation框架时,您可以将创建的任何字符串的值转换成,并调用任意的NSString API。
    可以在任意要求传入NSString实例作为参数的API中用String类型的值代替。
*/

//字符串字面量 String Literals
let someString = "Some string literal value"
var emptyString = ""
var emptyString1 = String()

print(emptyString.isEmpty)
print(emptyString1.isEmpty)
//Swift String是值类型


for character in "你是一只Dog?".characters {
    print(character)
}
let catCharacters: [Character] = ["C", "a", "t", "吗"]
let catString = String(catCharacters)
print(catString)

let myName = "\u{9A6C}\u{9A8F}"
let myNameAnd = "\u{9A6C}\u{20DD}\u{9A8F}\u{20DD}"
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
let dollarSign = "\u{24}" // $, Unicode 标量 U+0024
let blackHeart = "\u{2665}" // ?, Unicode 标量 U+2665
let sparklingHeart = "\u{1F496}" // ?, Unicode 标量 U+1F496
let eAcute: Character = "\u{E9}" // é
let combinedEAcute: Character = "\u{65}\u{301}"
/* 然而一个标准的字母￼e或者U+0065加上一个急促重音的标量( U+0301 ),这样一对标量就表示了同样的字母
é 。 这个急促重音的标量形象的将 e 转换成了 é 。*/
let precomposed: Character = "\u{D55C}" // ?
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"
let enclosedEAcute: Character = "\u{E9}\u{20DD}"

var word = "cafe"
print("the number of characters in \(word) is \(word.characters.count)")
word += "\u{301}" // COMBINING ACUTE ACCENT, U+0301
print("the number of characters in \(word) is \(word.characters.count)")

/* 注意:
可扩展的字符群集可以组成一个或者多个 Unicode 标量。这意味着不同的字符以及相同字符的不同表示方式可 能需要不同数量的内存空间来存储。所以 Swift 中的字符在一个字符串中并不一定占用相同的内存空间数量。因此在没有获取字符串的可扩展的字符群的范围时候,就不能计算出字符串的字符数量。
如果您正在处理一个长字符串,需要注意 characters 属性必须遍历全部的 Unicode 标量,来确定字符串的字符数量。
另外需要注意的是通过 characters 属性返回的字符数量并不总是与包含相同字符的 NSString 的 length 属性相同。 NSString 的 length 属性是利用 UTF-16 表示的十六位代码单元数字,而不是 Unicode 可扩展的字符 群集。作为佐证,当一个 NSString 的 length 属性被一个Swift的 String 值访问时,实际上是调用了
utf16count 。
*/


let greeting = "Guten Tag!"
greeting[greeting.startIndex]
greeting[greeting.startIndex.successor()]
let index = greeting.startIndex.advancedBy(9)
greeting[index]
greeting[greeting.endIndex.predecessor()]
//greeting[greeting.endIndex] // error
//greeting.endIndex.successor() // error
for index in greeting.characters.indices {
    print(greeting[index])
}

//插入和删除
var welcome = "hello"
welcome.insert("!", atIndex: welcome.endIndex)
welcome.insertContentsOf(" there".characters, at: welcome.endIndex.predecessor())
welcome.removeAtIndex(welcome.endIndex.predecessor())
let range = welcome.endIndex.advancedBy(-6)..<welcome.endIndex
welcome.removeRange(range)

//字符串/字符相等 (String and Character Equality)
let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
    print("These two strings are considered equal")
}

// "Voulez-vous un café?" 使用 LATIN SMALL LETTER E WITH ACUTE 
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
// "Voulez-vous un cafe??" 使用 LATIN SMALL LETTER E and COMBINING ACUTE ACCENT 
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
if eAcuteQuestion == combinedEAcuteQuestion {
    print("These two strings are considered equal")
}
/*
如果两个字符串(或者两个字符)的可扩展的字形群集是标准相等的,那就认为它们是相等的。
在这个情况下,即使可扩展的字形群集是有不同的 Unicode 标量构成的,只要它们有同样的语言意义和外观,就认为它们标准相等。
*/

let latinCapitalLetterA: Character = "\u{41}"
let cyrillicCapitalLetterA: Character = "\u{0410}"
if latinCapitalLetterA != cyrillicCapitalLetterA { print("These two characters are not equivalent")
}
/*
相反,英语中的A不等于俄语中的A两个字符看着是一样的,但却有不同的语言意义
*/


//前缀/后缀相等 (Prefix and Suffix Equality)
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]
var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 2 ") {
        ++act1SceneCount
    }
}
print("There are \(act1SceneCount) scenes in Act 1")

var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        ++mansionCount
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        ++cellCount
    }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")

//字符串的 Unicode 表示形式(Unicode Representations of Strings)
/*
    Swift提供了几种不同的方式来访问字符串的 Unicode 表示形式。
    您可以利用 for-in 来对字符串进行遍历,从 而以 Unicode 可扩展的字符群集的方式访问每一个 Character 值。
    另外,能够以其他三种 Unicode 兼容的方式访问字符串的值:
    1 UTF-8 代码单元集合 (利用字符串的 utf8 属性进行访问)
    2 UTF-16 代码单元集合 (利用字符串的 utf16 属性进行访问)
    3 21位的 Unicode 标量值集合,也就是字符串的 UTF-32 编码格式 (利用字符串的 unicodeScalars 属性进 行访问)
*/
//UTF-8 表示
let dogString = "Dog\u{203C}\u{1F436}"
for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
}
print("")
//UTF-16 表示
for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: "")
}
print("")
//Unicode 标量表示 (Unicode Scalars Representation)
for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ", terminator: "")
}
print("")
for scalar in dogString.unicodeScalars {
    print("\(scalar) ")
}







