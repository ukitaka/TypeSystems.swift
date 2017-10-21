//
// Created by ukitaka on 2017/10/18.
//

public struct AlgorithmW { }

public extension AlgorithmW {
    func w(_ p: TypedPrefix, _ f: Exp) -> (Substitution, TypedExp) {
        switch f {
        case let .var(x):
            if let member = p[x], p.isActive(member: .abs(x)) || p.isActive(member: .fix(x)) {
                return (Substitution.empty(), TypedExp.var(x, member.type))
            } else if p.isActive(member: .let(x)) {
                return (Substitution.empty(), TypedExp.var(x, Type.freshVar()))
            }
            fatalError("\(x) is not active in prefix")
        case let .app(d, e):
            let (r, dp) = w(p, d)
            let (s, es) = w(r.apply(to: p), e)
            let beta = Type.freshVar()
            let u = AlgorithmU.mostGeneralUnifier(s.apply(to: dp.type), .func(es.type, beta))
            let f = u.apply(to: TypedExp.app(s.apply(to: dp), es, beta))
            let t = u.union(s).union(r)
            return (t, f)
        default:
            fatalError()
        }
    }
}
