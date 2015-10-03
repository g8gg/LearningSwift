//: Playground - noun: a place where people can play

import Cocoa

//类型转换(Type Casting)


//类型转换 可以判断实例的类型，也可以将实例看做是其父类或者子类的实例。
//类型转换在 Swift 中使用 is 和 as 操作符实现。这两个操作符提供了一种简单达意的方式去检查值的类型或者转换它的类型。
//你也可以用它来检查一个类是否实现了某个协议，就像在 检验协议的一致性部分讲述的一样。



//定义一个类层次作为例子
//你可以将类型转换用在类和子类的层次结构上，检查特定类实例的类型并且转换这个类实例的类型成为这个层次结构中的其他类型。
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

//增加了一个 director（导演）属性，和相应的初始化器。
class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

//在父类的基础上增加了一个 artist（艺术家）属性，和相应的初始化器
class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

//创建一个数组常量 library，包含两个 Movie 实例和三个 Song 实例。library 的类型是在它被初始化时根据它数组中所包含的内容推断来的。Swift的类型检测器能够推理出 Movie 和 Song 有共同的父类 MediaItem，所以它推断出 [MediaItem] 类作为 library 的类型。
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]// the type of "library" is inferred to be [MediaItem]

//在幕后 library 里存储的媒体项依然是 Movie 和 Song 类型的。但是，若你迭代它，依次取出的实例会是 MediaItem 类型的，而不是 Movie 和 Song 类型。为了让它们作为原本的类型工作，你需要检查它们的类型或者向下转换它们到其它类型，就像下面描述的一样。

//检查类型（Checking Type）
//用类型检查操作符(is)来检查一个实例是否属于特定子类型。若实例属于那个子类型，类型检查操作符返回 true，否则返回 false。
var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        ++movieCount
    } else if item is Song {
        ++songCount
    }
}

print("Media library contains \(movieCount) movies and \(songCount) songs")


//向下转型（Downcasting）
//某类型的一个常量或变量可能在幕后实际上属于一个子类。当确定是这种情况时，你可以尝试向下转到它的子类型，用类型转换操作符(as? 或 as!)
//因为向下转型可能会失败，类型转型操作符带有两种不同形式。条件形式（conditional form） as? 返回一个你试图向下转成的类型的可选值（optional value）。强制形式 as! 把试图向下转型和强制解包（force-unwraps）结果作为一个混合动作。
//当你不确定向下转型可以成功时，用类型转换的条件形式(as?)。条件形式的类型转换总是返回一个可选值（optional value），并且若下转是不可能的，可选值将是 nil。这使你能够检查向下转型是否成功。
//只有你可以确定向下转型一定会成功时，才使用强制形式(as!)。当你试图向下转型为一个不正确的类型时，强制形式的类型转换会触发一个运行时错误。

//下面的例子，迭代了 library 里的每一个 MediaItem，并打印出适当的描述。要这样做，item 需要真正作为 Movie 或 Song 的类型来使用，不仅仅是作为 MediaItem。为了能够在描述中使用 Movie 或 Song 的 director 或 artist 属性，这是必要的。

//在这个示例中，数组中的每一个 item 可能是 Movie 或 Song。事前你不知道每个 item 的真实类型，所以这里使用条件形式的类型转换(as?)去检查循环里的每次下转。
print("")
for item in library {
    if let movie = item as? Movie {
        print("Movie: '\(movie.name)', dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: '\(song.name)', by \(song.artist)")
    }
}
//注意：
//转换没有真的改变实例或它的值。潜在的根本的实例保持不变；只是简单地把它作为它被转换成的类来使用。



//Any和AnyObject的类型转换
//Swift为不确定类型提供了两种特殊类型别名：
//AnyObject可以代表任何class类型的实例。
//Any可以表示任何类型，包括方法类型（function types）。
//注意：
//只有当你明确的需要它的行为和功能时才使用Any和AnyObject。在你的代码里使用你期望的明确的类型总是更好的。

//AnyObject类型
//当在工作中使用 Cocoa APIs，我们一般会接收一个[AnyObject]类型的数组，或者说“一个任何对象类型的数组”。这是因为 Objective-C 没有明确的类型化数组。但是，你常常可以从 API 提供的信息中清晰地确定数组中对象的类型。
//在这些情况下，你可以使用强制形式的类型转换(as)来下转在数组中的每一项到比 AnyObject 更明确的类型，不需要可选解析（optional unwrapping）。
//下面的示例定义了一个 [AnyObject] 类型的数组并填入三个Movie类型的实例：
print("")
let someObjects: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott")
]
//因为知道这个数组只包含 Movie 实例，你可以直接用(as!)下转并解包到不可选的Movie类型：
for object in someObjects {
    let movie = object as! Movie
    print("Movie: '\(movie.name)', dir. \(movie.director)")
}

//为了变为一个更短的形式，下转someObjects数组为[Movie]类型来代替下转数组中每一项的方式。
print("")
for movie in someObjects as! [Movie] {
    print("Movie: '\(movie.name)', dir. \(movie.director)")
}



//Any类型
//这里有个示例，使用 Any 类型来和混合的不同类型一起工作，包括方法类型和非 class 类型。它创建了一个可以存储Any类型的数组 things。
var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })
//things 数组包含两个 Int 值，2个 Double 值，1个 String 值，一个元组 (Double, Double) ，电影“Ghostbusters”，和一个获取 String 值并返回另一个 String 值的闭包表达式。
//你可以在 switch 表达式的cases中使用 is 和 as 操作符来发觉只知道是 Any 或 AnyObject 的常量或变量的类型。下面的示例迭代 things 数组中的每一项的并用switch语句查找每一项的类型。这几种 switch 语句的情形绑定它们匹配的值到一个规定类型的常量，让它们的值可以被打印：
print("")
for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called '\(movie.name)', dir. \(movie.director)")
    case let stringConverter as String -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}
//注意：
//在一个switch语句的case中使用强制形式的类型转换操作符（as, 而不是 as?）来检查和转换到一个明确的类型。在 switch case 语句的内容中这种检查总是安全的。


