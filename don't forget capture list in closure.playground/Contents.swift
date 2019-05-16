import UIKit
import Foundation
struct Item: Decodable {
    let name: String
}

struct DelegateCall<Input> {
    private(set) var callback: ((Input) -> Void)?
    
    mutating func delegate<Object: AnyObject>(to object: Object, with callback: @escaping (Object, Input) -> Void) {
        // ここで[weak object]としている
        self.callback = { [weak object] input in
            guard let object = object else {
                return
            }
            callback(object, input)
        }
    }
}

class TaskController {
    var delegateCall = DelegateCall<String>()
    
    private func hoge(bool: Bool) throws {
        guard bool else {
            throw NSError(domain: "error ", code: -1, userInfo: nil)
        }
    }
    
    func startTask() {
        do {
            try hoge(bool: true)
            self.delegateCall.callback?("完了後")
        } catch {
            // error
            fatalError()
        }
    }
}

class HogeController {
    private let taskController = TaskController()
    var message = "完了前"
    
    init() {
        print(self.message)
        taskController.delegateCall.delegate(to: self)  { (self, message) in
            self.message = message
            print(self.message)
        }
    }
    
    func start() {
        taskController.startTask()
    }
}

let hogeC = HogeController()
hogeC.start()
