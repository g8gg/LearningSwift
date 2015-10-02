//: Playground - noun: a place where people can play

import Cocoa

/**
*  下标脚本 SubScripts
*/
//下标脚本 可以定义在类(Class)、结构体(structure)和枚举(enumeration)这些目标中,可以认为是访问集合(collection),列表(list)或序列(sequence的快捷方式
//使用下标脚本的索引设置和获取值,不需要再调用实例的特定的赋值和访问方法。
//举例来说,用下标脚本访问一个数组(Array)实例中的元素可以这样写 someArray[index] ,访问字典(Dictionary)实例中的元素可以这样写someDictionary[key]。
//对于同一个目标可以定义多个下标脚本,通过索引值类型的不同来进行重载,下标脚本不限于单个纬度,你可以定义多个入参的下标脚本满足自定义类型的需求。

//下标脚本语法
//下标脚本允许你通过在实例后面的方括号中传入一个或者多个的索引值来对实例进行访问和赋值。
//与定义实例方法类似,定义下标脚本使用 subscript 关键字,显式声明入参(一个 或多个)和返回类型。与实例方法不同的是下标脚本可以设定为读写或只读。
/*
subscript(index: Int) -> Int {
    get {
        // 返回与入参匹配的Int类型的值 
    }
    set(newValue) { // 执行赋值操作
        }
}
*/

//与只读计算型属性一样,可以直接将原本应该写在 get 代码块中的代码写在 subscript 中
//subscript(index: Int) -> Int {
// 返回与入参匹配的Int类型的值
//}

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("3的6倍是\(threeTimesTable[6])")
//注意:
//TimesTable 例子是基于一个固定的数学公式。它并不适合对 threeTimesTable[someIndex] 进行赋值操作,这也是为什么附属脚本只定义为只读的原因。

//下标脚本用法
//根据使用场景不同下标脚本也具有不同的含义。通常下标脚本是用来访问集合(collection),列表(list)或序 列(sequence)中元素的快捷方式。

var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2
/**
*  注意：Swift 中字典的附属脚本实现中,在 get 部分返回值是 Int? ,上例中的 numberOfLegs 字典通过附属脚本返 回的是一个 Int? 或者说“可选的int”,不是每个字典的索引都能得到一个整型值,对于没有设过值的索引的访 问返回的结果就是 nil ;同样想要从字典实例中删除某个索引下的值也只需要给这个索引赋值为 nil 即可。
*/


//下标脚本选项
//下标脚本允许任意数量的入参索引,并且每个入参类型也没有限制。下标脚本的返回值也可以是任何类型。下标 脚本可以使用变量参数和可变参数,但使用写入读出(in-out)参数或给参数设置默认值都是不允许的。
//一个类或结构体可以根据自身需要提供多个下标脚本实现,在定义下标脚本时通过入参个类型进行区分,使用下标脚本时会自动匹配合适的下标脚本实现运行,这就是下标脚本的重载。
//一个下标脚本入参是最常见的情况,但只要有合适的场景也可以定义多个下标脚本入参。
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double { get {
        assert(indexIsValidForRow(row, column: column), "Index out of range")
        return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2
//let someValue = matrix[2, 2] //error



