import UIKit
import Foundation

protocol Animal {}

extension Animal {
    func hoge() {
        Playground.hoge(self)
    }
}

func hoge<T>(_ value: T) where T: Animal {
    print(value)
}

extension String: Animal {}

struct AnimalStruct {
    var a: Animal
    init() { a = "Animal" }
}



func hoge(_ animalStruct: AnimalStruct) {
    hoge(animalStruct.a) // Protocol type 'Animal' cannot conform to 'Animal' because only concrete types can conform to protocols
    // Existential が protocol自身にconfromしていないことが原因
    // Animal protocolのextensionで定義したメソッドを経由してhoge<T>(_ value: T) where T: Animalを呼び出すとコンパイルが通る
    animalStruct.a.hoge()
}

