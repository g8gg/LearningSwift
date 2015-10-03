//: Playground - noun: a place where people can play

import Cocoa

//错误处理(Error Handling)
//错误处理是响应错误以及从错误中返回的过程。swift提供第一类错误支持，包括在运行时抛出，捕获，传送和控制可回收错误。
//一些函数和方法不能总保证能够执行所有代码或产生有用的输出。可空类型用来表示值可能为空，但是当函数执行失败的时候，可空通常可以用来确定执行失败的原因，因此代码可以正确地响应失败。在Swift中，这叫做抛出函数或者抛出方法。
//注意： Swift中的错误处理涉及到错误处理样式，这会用到Cocoa中的NSError和Objective-C。
//https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/BuildingCocoaApps/AdoptingCocoaDesignPatterns.html#//apple_ref/doc/uid/TP40014216-CH7-ID174


/*
Catching and Handling an Error

In Objective-C, error handling is opt-in, meaning that errors produced by calling a method are ignored unless an error pointer is provided. In Swift, calling a method that throws requires explicit error handling.

Here’s an example of how to handle an error when calling a method in Objective-C:

NSFileManager *fileManager = [NSFileManager defaultManager];
NSURL *fromURL = [NSURL fileURLWithPath:@"/path/to/old"];
NSURL *toURL = [NSURL fileURLWithPath:@"/path/to/new"];
NSError *error = nil;
BOOL success = [fileManager moveItemAtURL:URL toURL:toURL error:&error];
if (!success) {
NSLog(@"Error: %@", error.domain);
}
*/


/*
And here’s the equivalent code in Swift:

let fileManager = NSFileManager.defaultManager()
let fromURL = NSURL(fileURLWithPath: "/path/to/old")
let toURL = NSURL(fileURLWithPath: "/path/to/new")
do {
    try fileManager.moveItemAtURL(fromURL, toURL: toURL)
} catch let error as NSError {
    print("Error: \(error.domain)")
}
*/


/*
Additionally, you can use catch clauses to match on particular error codes as a convenient way to differentiate possible failure conditions:
do {
try fileManager.moveItemAtURL(fromURL, toURL: toURL)
} catch NSCocoaError.FileNoSuchFileError {
print("Error: no such file exists")
} catch NSCocoaError.FileReadUnsupportedSchemeError {
print("Error: unsupported scheme (should be 'file://')")
}
*/


/**
Converting Errors to Optional Values

In Objective-C, you pass NULL for the error parameter when you only care whether there was an error, not what specific error occurred. In Swift, you write try? to change a throwing expression into one that returns an optional value, and then check whether the value is nil.

For example, the NSFileManager instance method URLForDirectory(_:inDomain:appropriateForURL:create:) returns a URL in the specified search path and domain, or produces an error if an appropriate URL does not exist and cannot be created. In Objective-C, the success or failure of the method can be determined by whether an NSURL object is returned.

NSFileManager *fileManager = [NSFileManager defaultManager];

NSURL *tmpURL = [fileManager URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];

if (tmpURL != nil) {
// ...
}
*/

/**
You can do the same in Swift as follows:
let fileManager = NSFileManager.defaultManager()
if let tmpURL = try? fileManager.URLForDirectory(.CachesDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true) {
// ...
}
*/


//Throwing an Error
/*
If an error occurs in an Objective-C method, that error is used to populate the error pointer argument of that method:
// an error occurred
if (errorPtr) {
*errorPtr = [NSError errorWithDomain:NSURLErrorDomain
code:NSURLErrorCannotOpenFile
userInfo:nil];
}

If an error occurs in a Swift method, the error is thrown, and automatically propagated to the caller:
// an error occurred
throw NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotOpenFile, userInfo: nil)
...
*/



//错误的表示：
//在Swift中，错误用符合ErrorType协议的值表示。 Swift枚举特别适合把一系列相关的错误组合在一起，同时可以把一些相关的值和错误关联在一起。因此编译器会为实现ErrorType协议的Swift枚举类型自动实现相应合成。


//比如说，你可以这样表示操作自动贩卖机会出现的错误：
enum VendingMachineError: ErrorType {
    case InvalidSelection
    case InsufficientFunds(required: Double)
    case OutOfStock
}


//错误抛出 通过在函数或方法声明的参数后面加上 throws 关键字,表明这个函数或方法可以抛出错误。如果指定 一个返回值,可以把 throws 关键字放在返回箭头(->)的前面。除非明确地指出,一个函数,方法或者就闭包不 能抛出错误。
//func canThrowErrors() throws -> String 
//func cannotThrowErrors() -> String

//在抛出函数体的任意一个地方，可以通过throw语句抛出错误。在下面的例子中，如果请求的物品不存在，或者卖完了，或者超出投入金额，vend(itemNamed:)函数会抛出一个错误：
struct Item {
    var price: Double
    var count: Int
}

//错误抛出 通过在函数或方法声明的参数后面加上throws关键字，表明这个函数或方法可以抛出错误。如果指定一个返回值，可以把throws关键字放在返回箭头(->)的前面。除非明确地指出，一个函数，方法或者闭包就不能抛出错误。

var inventory = [
    "Candy Bar": Item(price: 1.25, count: 7),
    "Chips": Item(price: 1.00, count: 0),
    "Pretzels": Item(price: 0.75, count: 11)
]
var amountDeposited = 1.00

func vend(itemNamed name: String) throws {
    guard var item = inventory[name] else {
        throw VendingMachineError.InvalidSelection
    }
    
    guard item.count > 0 else {
        throw VendingMachineError.OutOfStock
    }
    
    if amountDeposited >= item.price {
        // Dispense the snack
        amountDeposited -= item.price
        --item.count
        inventory[name] = item
    } else {
        let amountRequired = item.price - amountDeposited
        throw VendingMachineError.InsufficientFunds(required: amountRequired)
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

func buyFavoriteSnack(person: String) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vend(itemNamed: snackName)
}


//捕捉和处理错误
//使用do-catch语句来就捕获和处理错误
/* do {

try function that throws

statements

} catch pattern {

statements

}
*/
//如果一个错误被抛出了，这个错误会被传递到外部域，直到被一个catch分句处理。一个catch分句包含一个catch关键字，跟着一个pattern来匹配错误和相应的执行语句。
//类似switch语句，编译器会检查catch分句是否能够处理全部错误。如果能够处理所有错误情况，就认为这个错误被完全处理。否者，包含这个抛出函数的所在域就要处理这个错误，或者包含这个抛出函数的函数也用throws声明。为了保证错误被处理，用一个带pattern的catch分句来匹配所有错误。如果一个catch分句没有指定样式，这个分句会匹配并且绑定任何错误到一个本地error常量。
do {
    try vend(itemNamed: "Candy Bar")
    // Enjoy delicious snack
} catch VendingMachineError.InvalidSelection {
    print("Invalid Selection")
} catch VendingMachineError.OutOfStock {
    print("Out of Stock.")
} catch VendingMachineError.InsufficientFunds(let amountRequired) {
    print("Insufficient funds. Please insert an additional $\(amountRequired).")
}
//在上面的例子中，vend(itemNamed:) 函数在try表达式中被调用，因为这个函数会抛出错误。如果抛出了错误，程序执行流程马上转到catch分句，在catch分句中确定错误传递是否继续传送。如果没有抛出错误，将会执行在do语句中剩余的语句。
//注意：Swift中的错误处理和其他语言中的异常处理很像，使用了try、catch和throw关键字。但是和这些语言——包括Objective-C——不同的是，Swift不会展开调用堆栈，那会带来很大的性能损耗。因此，在Swift中throw语句的性能可以做到几乎和return语句一样。


//禁止错误传播
//在运行时，有几种情况抛出函数事实上是不会抛出错误的。在这几种情况下，你可以用forced-try表达式来调用抛出函数或方法，即使用try!来代替try。
//通过try!来调用抛出函数或方法禁止了错误传送，并且把调用包装在运行时断言，这样就不会抛出错误。如果错误真的抛出了，会触发运行时错误。
/*
func willOnlyThrowIfTrue(value: Bool) throws {
    if value { throw someError }
}

do {
    try willOnlyThrowIfTrue(false)
} catch {
    // Handle Error
}

try! willOnlyThrowIfTrue(false)
*/


//收尾操作
//使用defer语句来在执行一系列的语句。这样不管有没有错误发生，都可以执行一些必要的收尾操作。包括关闭打开的文件描述符以及释放所有手动分配的内存。
//defer语句把执行推迟到退出当前域的时候。defer语句包括defer关键字以及后面要执行的语句。被推迟的语句可能不包含任何将执行流程转移到外部的代码，比如break或者return语句，或者通过抛出一个错误。被推迟的操作的执行的顺序和他们定义的顺序相反，也就是说，在第一个defer语句中的代码在第二个defer语句中的代码之后执行。
/*
func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readline() {
            // Work with the file.
        }
        // close(file) is called here, at the end of the scope.
    }
}
*/
//上面这个例子使用了defer语句来保证open有对应的close。这个调用不管是否有抛出都会执行。



