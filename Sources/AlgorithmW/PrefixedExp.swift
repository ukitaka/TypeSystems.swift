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
        switch exp {
        case .var, .literal:
            return [self]
        case let .app(e1, e2):
            return [ PE(prefix, e1), PE(prefix, e2) ]
        case let .if(e1, e2, e3):
            return [ PE(prefix, e1), PE(prefix, e2), PE(prefix, e3) ]
        case let .abs(varName, e):
            return [ PE(prefix.appending(member: .abs(varName)), e) ]
        case let .fix(varName, e):
            return [ PE(prefix.appending(member: .fix(varName)), e) ]
        case let .let(varName, e1, e2):
            return [
                PE(prefix, e1),
                PE(prefix.appending(member: .let(varName)), e2)
            ]
        }
    }
}
