import Foundation

struct Pair<Value>: Sequence {
    private var array: [Value]
    
    init(_ value1: Value, _ value2: Value) {
        array = [value1, value2]
    }
    
    var values: (Value, Value) { return (array[0], array[1]) }
    
    func makeIterator() -> IndexingIterator<[Value]> {
        return array.makeIterator()
    }
}



let pair = Pair(1, 2)

let hoge = pair.makeIterator()
print(hoge)


