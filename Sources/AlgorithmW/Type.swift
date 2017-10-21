//
// Created by ukitaka on 2017/10/13.
//

public indirect enum Type {
    case int
    case bool
    case `func`(Type, Type)
    case typeVar(VarName)
}

public extension Type {
    public static func freshVar() -> Type {
        return .typeVar(VarName.fresh())
    }
}

extension Type: Equatable {
    public static func ==(lhs: Type, rhs: Type) -> Bool {
        switch (lhs, rhs) {
        case (.int, .int):
            return true
        case (.bool, .bool):
            return true
        case let (.func(arg1, ret1), .func(arg2, ret2)):
            return arg1 == arg2 && ret1 == ret2
        case let (.typeVar(varName1), .typeVar(varName2)):
            return varName1 == varName2
        default:
            return false
        }
    }
}

extension Type: CustomStringConvertible {
    public var description: String {
        switch self{
        case .int:
            return "Int"
        case .bool:
            return "Bool"
        case let .func(arg, ret):
            return "\(arg) → \(ret)"
        case let .typeVar(varName):
            return varName.name
        }
    }
}