//: Playground - noun: a place where people can play

import Cocoa

//嵌套类型（Nested Types）
//枚举类型常被用于实现特定类或结构体的功能。也能够在有多种变量类型的环境中，方便地定义通用类或结构体来使用，为了实现这种功能，Swift允许你定义嵌套类型，可以在枚举类型、类和结构体中定义支持嵌套的类型。
//要在一个类型中嵌套另一个类型，将需要嵌套的类型的定义写在被嵌套类型的区域{}内，而且可以根据需要定义多级嵌套。

//嵌套类型实例
//下面这个例子定义了一个结构体BlackjackCard(二十一点)，用来模拟BlackjackCard中的扑克牌点数。BlackjackCard结构体包含2个嵌套定义的枚举类型Suit 和 Rank。
//在BlackjackCard规则中，Ace牌可以表示1或者11，Ace牌的这一特征用一个嵌套在枚举型Rank的结构体Values来表示。
struct BlackjackCard {
    // 嵌套定义枚举型Suit
    enum Suit: Character {
        case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    }
    
    // 嵌套定义枚举型Rank
    enum Rank: Int {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard 的属性和方法
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

//枚举型的Suit用来描述扑克牌的四种花色，并分别用一个Character类型的值代表花色符号。
//枚举型的Rank用来描述扑克牌从Ace~10,J,Q,K,13张牌，并分别用一个Int类型的值表示牌的面值。(这个Int类型的值不适用于Ace,J,Q,K的牌)。
//如上文所提到的，枚举型Rank在自己内部定义了一个嵌套结构体Values。在这个结构体中，只有Ace有两个数值，其余牌都只有一个数值。结构体Values中定义的两个属性：
//first为Int
//second为 Int? 或 “optional Int”
//Rank定义了一个计算属性values，它将会返回一个结构体Values的实例。这个计算属性会根据牌的面值，用适当的数值去初始化Values实例，并赋值给values。对于J,Q,K,Ace会使用特殊数值，对于数字面值的牌使用Int类型的值。

//BlackjackCard结构体自身有两个属性—rank与suit，也同样定义了一个计算属性description，description属性用rank和suit的中内容来构建对这张扑克牌名字和数值的描述，并用可选类型second来检查是否存在第二个值，若存在，则在原有的描述中增加对第二数值的描述。

//因为BlackjackCard是一个没有自定义构造函数的结构体，在结构体的逐一成员构造器中知道结构体有默认的成员构造函数，所以你可以用默认的initializer去初始化新的常量theAceOfSpades:
let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
let theJackHearts = BlackjackCard(rank: .Jack, suit: .Hearts)
let a = BlackjackCard(rank: .Queen, suit: .Diamonds)
print("theAceOfSpades: \(theAceOfSpades.description)")
print("")
print("theJackHearts: \(theJackHearts.description)")
print("")
print(a.description)

//尽管Rank和Suit嵌套在BlackjackCard中，但仍可被引用，所以在初始化实例时能够通过枚举类型中的成员名称单独引用。在上面的例子中description属性能正确得输出对Ace牌有1和11两个值。


//嵌套类型的引用
//在外部对嵌套类型的引用，以被嵌套类型的名字为前缀，加上所要引用的属性名：
let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue
//对于上面这个例子，这样可以使Suit, Rank, 和 Values的名字尽可能的短，因为它们的名字会自然的由定义它们的上下文来限定。


