//
// Created by Yuki Takahashi on 2017/10/20.
//

public struct PrefixedExp {
    let prefix: Prefix
    let exp: Exp

    public init(prefix: Prefix, exp: Exp) {
        self.prefix = prefix
        self.exp = exp
    }
}

// MARK: 3.5 Type Assignments

public extension PrefixedExp {
    private func PE(_ prefix: Prefix, _ exp: Exp) -> PrefixedExp {
        return .init(prefix: prefix, exp: exp)
    }

    public var subPrefixedExps: [PrefixedExp] {
        fatalError()
//        switch exp {
//        case let .var(varName):
//            return [self]
//        case let .app(exp1, exp2):
//            return [ PE(prefix, exp1), PE(prefix, exp2) ]
//        case let .i
//
//        }
    }
}
