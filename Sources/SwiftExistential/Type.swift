//
// Created by Yuki Takahashi on 2017/10/28.
//

import Foundation

public indirect enum Type {
    case `var`(Name)
    case int
    case void
    case bool
    case `func`(Type, Type)
    case existential(Name, Type)
}

extension Type: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .var(name):
            return name
        case .int:
            return "Int"
        case .void:
            return "Void"
        case .bool:
            return "Bool"
        case let .func(arg, ret):
            return "\(arg) -> \(ret)"
        case let .existential(name, type):
            return "(∃\(name), \(type))"
        }
    }
}

extension Type: Hashable {
    public var hashValue: Int {
        return self.description.hashValue
    }

    public static func ==(lhs: Type, rhs: Type) -> Bool {
        switch (lhs, rhs) {
        case let (.var(name1), .var(name2)):
            return name1 == name2
        case (.int, .int):
            return true
        case (.bool, .bool):
            return true
        case let (.func(arg1, ret1), .func(arg2, ret2)):
            return arg1 == arg2 && ret1 == ret2
        case let (.existential(name1, type1), .existential(name2, type2)):
            return name1 == name2 && type1 == type2
        default:
            return false
        }
    }
}
