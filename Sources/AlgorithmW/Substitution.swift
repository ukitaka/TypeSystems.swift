//
// Created by Yuki Takahashi on 2017/10/18.
//

import Utils

public struct Substitution {
    private let map: [VarName: Type]

    init() {
        self.map = [:]
    }

    init(map: [VarName: Type]) {
        self.map = map
    }

    init(varName: VarName, type: Type) {
        self.map = [varName: type]
    }

    public func removing(varName: VarName) -> Substitution {
        return Substitution(map: self.map.removing(key: varName))
    }

    public func apply(to type: Type) -> Type {
        switch type {
        case let .typeVar(name):
            if let t = map[name] {
                return apply(to: t)
            } else {
                return type
            }
        case let .func(arg, ret):
            return .func(apply(to: arg), apply(to: ret))
        case .bool:
            return .bool
        case .int:
            return .int
        }
    }

    public func apply(to p: TypedPrefix) -> TypedPrefix {
        return p.apply(substitution: self)
    }

    public func apply(to e: TypedExp) -> TypedExp {
        return e.apply(substitution: self)
    }
}

// MARK: union

public extension Substitution {
    public func union(_ other: Substitution) -> Substitution {
        return Substitution(map: self.map.merging(other.map) { _, type in type })
    }

    public static func ∪(lhs: Substitution, rhs: Substitution) -> Substitution {
        return lhs.union(rhs)
    }
}

// MARK: alias of `init`

public extension Substitution {
    public static func empty() -> Substitution {
        return Substitution()
    }

    public static func singleton(varName: VarName, type: Type) -> Substitution {
        return Substitution(varName: varName, type: type)
    }
}

// MARK: CustomStringConvertible

extension Substitution: CustomStringConvertible {
    public var description: String {
        if map.isEmpty {
            return "[]"
        } else {
            return "[\n" + map.map { (key, val) in "\(key) ↦ \(val)" }.joined(separator: ",\n") + "\n]"
        }
    }
}
