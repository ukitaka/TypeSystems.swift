//
// Created by Yuki Takahashi on 2017/10/18.
//

import Utils

public struct Substitution {
    private let map: [VarName: Type]

    public func removing(varName: VarName) -> Substitution {
        return Substitution(map: self.map.removing(key: varName))
    }

    public func apply(to type: Type) -> Type {
        switch type {
        case let .typeVar(name):
            return map[name] ?? type
        case let .func(arg, ret):
            return .func(apply(to: arg), apply(to: ret))
        case .bool:
            return .bool
        case .int:
            return .int
        }
    }
}
