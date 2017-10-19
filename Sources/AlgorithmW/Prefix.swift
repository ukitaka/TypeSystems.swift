//
// Created by ukitaka on 2017/10/13.
//

public struct Prefix {
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
}

// MARK: alias of `init`

public extension Prefix {
    public static func empty() -> Prefix {
        return Prefix()
    }

    public static func singleton(varName: VarName, type: Type) -> Prefix {
        return Prefix(varName: varName, type: type)
    }
}
