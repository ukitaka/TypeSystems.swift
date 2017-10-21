//
// Created by ukitaka on 2017/10/18.
//

public struct AlgorithmW { }

public extension AlgorithmW {
    public static func w(_ p: TypedPrefix, _ f: Exp) -> (Substitution, TypedExp) {
//        print("------------------")
//        print("p: \(p)")
//        print("f: \(f)")
        switch f {
        case let .literal(literal):
            switch literal {
            case .bool:
                print("return: -----------------------=")
                print("substitution: \(Substitution.empty())")
                print("typed exp: \(TypedExp.literal(literal, .bool)))")
                return (.empty(), .literal(literal, .bool))
            case .int:
                print("return: -----------------------=")
                print("substitution: \(Substitution.empty())")
                print("typed exp: \(TypedExp.literal(literal, .int)))")
                return (.empty(), .literal(literal, .int))
            }
        case let .var(x):
            if let member = p[x], p.isActive(member: .abs(x)) || p.isActive(member: .fix(x)) {
                print("return var1: -----------------------=")
                print("substitution: \(Substitution.empty())")
                print("typed exp: \(TypedExp.var(x, member.type))")
                return (Substitution.empty(), TypedExp.var(x, member.type))
            } else if let member = p[x], p.isActive(member: .let(x)) {
                print("return var2: -----------------------=")
                print("substitution: \(Substitution.empty())")
                //TODO: member.typeの自由な出現をすべてfreshなVarで置き換える
                let result = (Substitution.empty(), TypedExp.var(x, Type.freshVar()))
                print("typed exp: \(result.1)")
                return result
            }
            fatalError("\(x) is not active in prefix")
        case let .app(d, e):
            let (r, dp) = w(p, d)
            let (s, es) = w(r.apply(to: p), e)
            let beta = Type.freshVar()
            let u = AlgorithmU.mostGeneralUnifier(s.apply(to: dp.type), .func(es.type, beta))
            let f = u.apply(to: TypedExp.app(s.apply(to: dp), es, beta))
            let t = u.union(s).union(r)
            print("return: -----------------------=")
            print("substitution: \(t)")
            print("typed exp: \(f)")
            return (t, f)
        case let .if(d, e, ed):
            let (r, dp) = w(p, d)
            let u0 = AlgorithmU.mostGeneralUnifier(dp.type, .bool)
            let (s, es) = w(u0.apply(to: r.apply(to: p)), e)
            let (sd, esd) = w(s.apply(to: u0.apply(to: r.apply(to: p))), ed)
            let u = AlgorithmU.mostGeneralUnifier(sd.apply(to: es.type), esd.type)
            let t = u.union(sd).union(s).union(u0).union(r)
            let f = u.apply(to: .if(sd.union(s).union(u0).apply(to: dp), sd.apply(to: es), esd, es.type))
            print("return: -----------------------=")
            print("substitution: \(t)")
            print("typed exp: \(f)")
            return (t, f)
        case let .abs(x, d):
            let beta = Type.freshVar()
            let (r, dp) = w(p.appending(member: .abs(x, beta)), d)
            let result: (Substitution, TypedExp) = (r, .abs(x, r.apply(to: beta), dp, .func(r.apply(to: beta), dp.type)))
            print("return: -----------------------=")
            print("substitution: \(result.0)")
            print("typed exp: \(result.1)")
            return result
        case let .fix(x, d):
            let beta = Type.freshVar()
            let (r, dp) = w(p.appending(member: .fix(x, beta)), d)
            let u = AlgorithmU.mostGeneralUnifier(r.apply(to: beta), dp.type)
            let t = u.union(r)
            let f = TypedExp.fix(x, t.apply(to: beta), u.apply(to: dp), t.apply(to: beta))
            print("return: -----------------------=")
            print("substitution: \(t)")
            print("typed exp: \(f)")
            return (t, f)
        case let .let(x, d, e):
            let (r, dp) = w(p, d)
            let (s, es) = w(r.apply(to: p).appending(member: .let(x, dp.type)), e)
            let t = s.union(r)
            let f = TypedExp.let(x, s.apply(to: dp.type), s.apply(to: dp), es, dp.type)
            print("return: -----------------------=")
            print("substitution: \(t)")
            print("typed exp: \(f)")
            return (t, f)
        }
    }
}
