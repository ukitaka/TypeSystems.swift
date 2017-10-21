//
// Created by ukitaka on 2017/10/21.
//

import Utils

public indirect enum TypedExp {
    case `var`(VarName, Type)
    case literal(Literal, Type)
    case `if`(TypedExp, TypedExp, TypedExp, Type)
    case abs(VarName, Type, TypedExp, Type)
    case app(TypedExp, TypedExp, Type)
    case `let`(VarName, Type, TypedExp, TypedExp, Type)
    case fix(VarName, Type, TypedExp, Type)
}

public extension TypedExp {
    public var type: Type {
        switch self {
        case let .var(_, type):
            return type
        case let .literal(_, type):
            return type
        case let .if(_, _, _, type):
            return type
        case let .abs(_, _, _, type):
            return type
        case let .app(_, _, type):
            return type
        case let .let(_, _, _, _, type):
            return type
        case let .fix(_, _,  _, type):
            return type
        }
    }

    public func apply(substitution s: Substitution) -> TypedExp {
        switch self {
        case let .var(varName, type):
            return .var(varName, s.apply(to: type))
        case let .literal(literal, type):
            return .literal(literal, s.apply(to: type))
        case let .if(cond, then, els, type):
            return .if(s.apply(to: cond), s.apply(to: then), s.apply(to: els), s.apply(to: type))
        case let .abs(varName, argType, body, absType):
            return .abs(varName, s.apply(to: argType), s.apply(to: body), s.apply(to: absType))
        case let .app(fun, arg, type):
            return .app(s.apply(to: fun), s.apply(to: arg), s.apply(to: type))
        case let .let(varName, varType, bind, body, type):
            return .let(varName, s.apply(to: varType), s.apply(to: bind), s.apply(to: body), s.apply(to: type))
        case let .fix(varName, varType, exp, type):
            return .fix(varName, s.apply(to: varType), s.apply(to: exp), s.apply(to: type))
        }
    }
}

// MARK: - Equatable

extension TypedExp: Equatable {
    public static func ==(lhs: TypedExp, rhs: TypedExp) -> Bool {
        switch (lhs, rhs) {
        case let (.var(v1, t1), .var(v2, t2)):
            return v1 == v2 && t1 == t2
        case let (.literal(l1, t1), .literal(l2, t2)):
            return l1 == l2 && t1 == t2
        case let (.if(c1, t1, e1, ty1), .if(c2, t2, e2, ty2)):
            return c1 == c2 && t1 == t2 && e1 == e2 && ty1 == ty2
        case let (.abs(v1, vty1, t1, ty1), .abs(v2, vty2, t2, ty2)):
            return v1 == v2 && vty1 == vty2 && t1 == t2 && ty1 == ty2
        case let (.app(tl1, tl2, tyl), .app(tr1, tr2, tyr)):
            return tl1 == tr1 && tl2 == tr2 && tyl == tyr
        case let (.let(n1, vtv1, bind1, body1, t1), .let(n2, vtv2, bind2, body2, t2)):
            return n1 == n2 && vtv1 == vtv2 && bind1 == bind2 && body1 == body2 && t1 == t2
        case let (.fix(n1, vtv1, e1, t1), .fix(n2, vtv2, e2, t2)):
            return n1 == n2 && vtv1 == vtv2 && e1 == e2 && t1 == t2
        default:
            return false
        }
    }
}

// MARK: - CustomStringConvertible

extension TypedExp: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .var(varName, type):
            return "\(varName.name):\(type)"
        case let .literal(literal, type):
            return "\(literal.description):\(type)"
        case let .if(cond, then, els, type):
            return "(if \(cond) then \(then) else \(els)):\(type)"
        case let .abs(varName, varType, exp, expType):
            return "(λ\(varName):\(varType). \(exp)):\(expType)"
        case let .app(fun, arg, type):
            return "(\(fun) \(arg)):\(type)"
        case let .let(varName, varType, bind, body, bodyType):
            return "let \(varName):\(varType) = \(bind) in \(body):\(bodyType)"
        case let .fix(varName, varType, exp, expType):
            return "fix \(varName):\(varType). \(exp):\(expType)"
        }
    }
}
