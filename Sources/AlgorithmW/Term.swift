//
// Created by ukitaka on 2017/10/12.
//

import Utils

public indirect enum Term {
    case `var`(VarName)
    case literal(Literal)
    case abs(VarName, Term)
    case app(Term, Term)
    case `let`(VarName, Term, Term)
}

// MARK: - Equatable

extension Term: Equatable {
    public static func ==(lhs: Term, rhs: Term) -> Bool {
        switch (lhs, rhs) {
        case let (.var(v1), .var(v2)):
            return v1 == v2
        case let (.literal(l1), .literal(l2)):
            return l1 == l2
        case let (.abs(v1, t1), .abs(v2, t2)):
            return v1 == v2 && t1 == t2
        case let (.app(tl1, tl2), .app(tr1, tr2)):
            return tl1 == tr1 && tl2 == tr2
        case let (.let(n1, bind1, body1), .let(n2, bind2, body2)):
            return n1 == n2 && bind1 == bind2 && body1 == body2
        default:
            return false
        }
    }
}

// MARK: - Free variables
//
// 3.5 Type assignments
//
public extension Term {
    var freeVars: Set<VarName> {
        switch self {
        case let .var(varName):
            return Set.singleton(varName)
        case .literal:
            return Set.empty()
        case let .abs(varName, term):
            return term.freeVars / Set.singleton(varName)
        case let .app(fun, arg):
            return fun.freeVars ∪ arg.freeVars
        case let .let(varName, bind, body):
            return bind.freeVars ∪ (body.freeVars / Set.singleton(varName))
        }
    }
}
