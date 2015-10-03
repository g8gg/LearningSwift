//: Playground - noun: a place where people can play

import Cocoa

//析构过程（Deinitialization）
//析构器只适用于类类型，当一个类的实例被释放之前，析构器会被立即调用。析构器用关键字deinit来标示，类似于构造器要用init来标示。

//析构过程原理
//Swift 会自动释放不再需要的实例以释放资源。
//Swift 通过自动引用计数（ARC）处理实例的内存管理。
//通常当你的实例被释放时不需要手动地去清理。但是，当使用自己的资源时，你可能需要进行一些额外的清理。例如，如果创建了一个自定义的类来打开一个文件，并写入一些数据，你可能需要在类实例被释放之前手动去关闭该文件。

//在类的定义中，每个类最多只能有一个析构器，而且析构器不带任何参数，如下所示：
/*
deinit {
    // 执行析构过程
}
*/
//析构器是在实例释放发生前被自动调用。
//析构器是不允许被主动调用的。
//子类继承了父类的析构器，并且在子类析构器实现的最后，父类的析构器会被自动调用。即使子类没有提供自己的析构器，父类的析构器也同样会被调用。
//因为直到实例的析构器被调用时，实例才会被释放，所以析构器可以访问所有请求实例的属性，并且根据那些属性可以修改它的行为（比如查找一个需要被关闭的文件）。


//析构器操作
//这是一个析构器操作的例子。这个例子描述了一个简单的游戏，这里定义了两种新类型，分别是Bank和Player。Bank结构体管理一个虚拟货币的流通，在这个流通中我们设定Bank永远不可能拥有超过 10,000 的硬币，而且在游戏中有且只能有一个Bank存在，因此Bank结构体在实现时会带有静态属性和静态方法来存储和管理其当前的状态。

struct Bank {
    static var coinsInBank = 10_000
    static func vendCoins(var numberOfCoinsToVend: Int) -> Int {
        numberOfCoinsToVend = min(numberOfCoinsToVend, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receiveCoins(coins: Int) {
        coinsInBank += coins
    }
}

//Player类描述了游戏中的一个玩家。每一个 player 在任何时刻都有一定数量的硬币存储在他们的钱包中。这通过 player 的coinsInPurse属性来体现：
class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.vendCoins(coins)
    }
    func winCoins(coins: Int) {
        coinsInPurse += Bank.vendCoins(coins)
    }
    deinit {
        Bank.receiveCoins(coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
print("There are now \(Bank.coinsInBank) coins left in the bank")
//一个新的Player实例被创建时会设定有 100 个硬币（如果bank对象中硬币的数目足够）。这个Player实例存储在一个名为playerOne的可选Player变量中。这里使用一个可选变量，是因为玩家可以随时离开游戏。设置为可选使得你可以跟踪当前是否有玩家在游戏中。

//因为playerOne是可选的，所以用一个感叹号（!）作为修饰符，每当其winCoins(_:)方法被调用时，coinsInPurse属性就会被访问并打印出它的默认硬币数目。
playerOne!.winCoins(2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
print("The bank now only has \(Bank.coinsInBank) coins left")

playerOne = nil //deinit
print("PlayerOne has left the game")
print("The bank now has \(Bank.coinsInBank) coins")


