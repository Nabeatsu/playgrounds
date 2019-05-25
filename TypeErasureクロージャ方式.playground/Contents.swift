import Foundation


protocol AnimalProtocol {
    associatedtype Food
    func eat(food: Food)
}


class Cat: AnimalProtocol {
    var name: String = "Cat"
    func eat(food: String) {
        print("きゃっとふーど: \(food)")
    }
}

// var a: AnimalProtocol = Cat() // Protocol 'AnimalProtocol' can only be used as a generic constraint because it has Self or associated type requirements

// a.eat(food: "hoge") // Existentialはそれ自身がprotocolにconformしていない
func g<X: AnimalProtocol>(_ x: X) {
    
}
// g(a) // Protocol type 'AnimalProtocol' cannot conform to 'AnimalProtocol' because only concrete types can conform to protocols

class AnimalHouse<X: AnimalProtocol> {}
// let animalHouse = AnimalHouse<AnimalProtocol>() //Protocol type 'AnimalProtocol' cannot conform to 'AnimalProtocol' because only concrete types can conform to protocols

class AnyAnimalクロージャ方式<Food>: AnimalProtocol {
    private let _eat: (Food) -> Void
    init<X: AnimalProtocol>(_ base: X) where X.Food == Food {
        _eat = { base.eat(food: $0) }
    }
    
    func eat(food: Food) {
        _eat(food)
    }
}


let anyA: AnyAnimalクロージャ方式 = AnyAnimalクロージャ方式(Cat())
anyA.eat(food: "hogeghoge")

func anyAnimalクロージャ方式g<X: AnyAnimalクロージャ方式<String>>(_ anyX: X) {
    anyX.eat(food: "anyExistential方式ghoge")
}
class AnyExistential方式AnimalHouse<X: AnyAnimalクロージャ方式<String>> {}
let anyExistential方式AnimalHouse: AnyAnimalクロージャ方式<String> = AnyAnimalクロージャ方式(anyA)
anyAnimalクロージャ方式g(anyA)

// きゃっとふーど: hogeghoge
// きゃっとふーど: anyExistential方式ghoge
