import Foundation


protocol AnimalProtocol {
    func eat(food: String)
}


class Cat: AnimalProtocol {
    var name: String = "Cat"
    func eat(food: String) {
        print("きゃっとふーど: \(food)")
    }
}

var a: AnimalProtocol = Cat()
a.eat(food: "hoge") // Existentialはそれ自身がprotocolにconformしていない
func g<X: AnimalProtocol>(_ x: X) {
    
}
// g(a) // Protocol type 'AnimalProtocol' cannot conform to 'AnimalProtocol' because only concrete types can conform to protocols

class AnimalHouse<X: AnimalProtocol> {}
// let animalHouse = AnimalHouse<AnimalProtocol>() //Protocol type 'AnimalProtocol' cannot conform to 'AnimalProtocol' because only concrete types can conform to protocols


// type erasure existential方式
class AnyAnimalExistential方式: AnimalProtocol {
    private let base: AnimalProtocol
    init(_ base: AnimalProtocol) {
        self.base = base
    }
    
    func eat(food: String) {
        base.eat(food: food)
    }
}

let anyA: AnyAnimalExistential方式 = AnyAnimalExistential方式(Cat())
anyA.eat(food: "hogeghoge")

func anyExistential方式g<X: AnyAnimalExistential方式>(_ anyX: X) {
    anyX.eat(food: "anyExistential方式ghoge")
}
class AnyExistential方式AnimalHouse<X: AnyAnimalExistential方式> {}
let anyExistential方式AnimalHouse: AnyExistential方式AnimalHouse<AnyAnimalExistential方式> = AnyExistential方式AnimalHouse()
anyExistential方式g(anyA)

// きゃっとふーど: hoge
// きゃっとふーど: hogeghoge
// きゃっとふーど: anyExistential方式ghoge
