//
// Created by ukitaka on 2017/10/13.
//

public struct Env {
    private let map: [VarName: Type]

    public init() {
        self.map = [:]
    }

    public init(varName: VarName, type: Type) {
        self.map = [varName: type]
    }

    public subscript(_ varName: VarName) -> Type? {
        return map[varName]
    }

    public subscript(_ variable: Exp) -> Type? {
        switch variable {
        case let .var(varName):
            return map[varName]
        default:
            return nil
        }
    }
}

// MARK: alias of `init`

public extension Env {
    public static func empty() -> Env {
        return Env()
    }

    public static func singleton(varName: VarName, type: Type) -> Env {
        return Env(varName: varName, type: type)
    }
}
