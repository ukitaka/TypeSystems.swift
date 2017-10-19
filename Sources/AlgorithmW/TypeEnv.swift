//
// Created by ukitaka on 2017/10/13.
//

public struct TypeEnv {
    private let env: [VarName: Type]

    public init() {
        self.env = [:]
    }

    public init(varName: VarName, type: Type) {
        self.env = [varName: type]
    }

    public subscript(_ varName: VarName) -> Type? {
        return env[varName]
    }
}

// MARK: alias of `init`

public extension TypeEnv {
    public static func empty() -> TypeEnv {
        return TypeEnv()
    }

    public static func singleton(varName: VarName, type: Type) -> TypeEnv {
        return TypeEnv(varName: varName, type: type)
    }
}
