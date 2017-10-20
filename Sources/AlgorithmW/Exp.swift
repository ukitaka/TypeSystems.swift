//
// Created by ukitaka on 2017/10/12.
//

import Utils

public indirect enum Exp {
    case `var`(VarName)
    case literal(Literal)
    case `if`(Exp, Exp, Exp)
    case abs(VarName, Exp)
    case app(Exp, Exp)
    case `let`(VarName, Exp, Exp)
    case fix(VarName, Exp)
}

// MARK: - Equatable

extension Exp: Equatable {
    public static func ==(lhs: Exp, rhs: Exp) -> Bool {
        switch (lhs, rhs) {
        case let (.var(v1), .var(v2)):
            return v1 == v2
        case let (.literal(l1), .literal(l2)):
            return l1 == l2
        case let (.if(c1, t1, e1), .if(c2, t2, e2)):
            return c1 == c2 && t1 == t2 && e1 == e2
        case let (.abs(v1, t1), .abs(v2, t2)):
            return v1 == v2 && t1 == t2
        case let (.app(tl1, tl2), .app(tr1, tr2)):
            return tl1 == tr1 && tl2 == tr2
        case let (.let(n1, bind1, body1), .let(n2, bind2, body2)):
            return n1 == n2 && bind1 == bind2 && body1 == body2
        case let (.fix(n1, e1), .fix(n2, e2)):
            return n1 == n2 && e1 == e2
        default:
            return false
        }
    }
}
