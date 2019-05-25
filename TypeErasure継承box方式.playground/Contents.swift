import Foundation


protocol AnimalProtocol {
    associatedtype Food
    func eat(food: Food)
    func spawn() -> Self
    func fight(_ x: Self)
}


class Cat: AnimalProtocol {
    func spawn() -> Self {
        return self
    }
    
    func fight(_ x: Cat) {
        print(x)
    }
    
    var name: String = "Cat"
    func eat(food: String) {
        print("きゃっとふーど: \(food)")
    }
}

// protocolをを保持するオブジェクトを内部にもう一つ作ってSelfを型パラメータに焼いて継承でそれを消してTypeErasureとする
// 意味がわからん
// コードを書いて動作をみてみる

class AnyAnimalBox<Food> {
    func eat(food: Food) { fatalError() }
    func spawn() -> AnyAnimalBox<Food>{ fatalError() }
    func fight(_ x: AnyAnimalBox<Food>){ fatalError() }
}

class AnimalBox<X: AnimalProtocol> : AnyAnimalBox<X.Food> {
    private let base: X
    init(_ base: X)  {
        self.base = base
    }
    
    override func eat(food: X.Food) {
        base.eat(food: food)
    }
    
    override func spawn() -> AnyAnimalBox<X.Food> {
        return AnimalBox<X>(base.spawn())
    }
    
    override func fight(_ x: AnyAnimalBox<X.Food>) {
        base.fight((x as! AnimalBox<X>).base)
    }
}

final class AnyAnimal継承Box方式<Food> : AnimalProtocol {
    private let box: AnyAnimalBox<Food>
    init<X: AnimalProtocol>(_ base: X) where X.Food == Food {
        box = AnimalBox<X>(base)
    }
    
    func eat(food: Food) {
        box.eat(food: food)
    }
    
    func spawn() -> AnyAnimal継承Box方式<Food> {
        return AnyAnimal継承Box方式<Food>(box: box.spawn())
    }
    
    func fight(_ x: AnyAnimal継承Box方式<Food>) {
        box.fight(x.box)
    }
    
    private init(box: AnyAnimalBox<Food>) {
        self.box = box
    }
}



// var a: AnimalProtocol = Cat() // Protocol 'AnimalProtocol' can only be used as a generic constraint because it has Self or associated type requirements

// a.eat(food: "hoge") // Existentialはそれ自身がprotocolにconformしていない
func g<X: AnimalProtocol>(_ x: X) {
    
}
// g(a) // Protocol type 'AnimalProtocol' cannot conform to 'AnimalProtocol' because only concrete types can conform to protocols

class AnimalHouse<X: AnimalProtocol> {}
// let animalHouse = AnimalHouse<AnimalProtocol>() //Protocol type 'AnimalProtocol' cannot conform to 'AnimalProtocol' because only concrete types can conform to protocols


let anyA: AnyAnimal継承Box方式 = AnyAnimal継承Box方式(Cat())
anyA.eat(food: "hogeghoge")
anyA.fight(anyA)
print(anyA.spawn())

func anyAnimal継承Box方式g<X: AnyAnimal継承Box方式<String>>(_ anyX: X) {
    anyX.eat(food: "anyAnimal継承Box方式ghoge")
}
class AnyAnimal継承Box方式AnimalHouse<X: AnyAnimal継承Box方式<String>> {}
let anyExistential方式AnimalHouse: AnyAnimal継承Box方式<String> = AnyAnimal継承Box方式(anyA)
anyAnimal継承Box方式g(anyA)

// きゃっとふーど: hogeghoge
// __lldb_expr_96.Cat
// __lldb_expr_96.AnyAnimal継承Box方式<Swift.String>
// きゃっとふーど: anyAnimal継承Box方式ghoge
