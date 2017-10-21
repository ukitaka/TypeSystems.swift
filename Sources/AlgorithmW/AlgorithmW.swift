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
        case let .if(d, e, ed):
            let (r, dp) = w(p, d)
            let u0 = AlgorithmU.mostGeneralUnifier(dp.type, .bool)
            let (s, es) = w(u0.apply(to: r.apply(to: p)), e)
            let (sd, esd) = w(s.apply(to: u0.apply(to: r.apply(to: p))), ed)
            let u = AlgorithmU.mostGeneralUnifier(sd.apply(to: es.type), esd.type)
            let t = u.union(sd).union(s).union(u0).union(r)
            let f = u.apply(to: .if(sd.union(s).union(u0).apply(to: dp), sd.apply(to: es), esd, es.type))
            return (t, f)
        case let .abs(x, d):
            let beta = Type.freshVar()
            let (r, dp) = w(p.appending(member: .abs(x, beta)), d)
            return (r, .abs(x, r.apply(to: beta), dp, .func(r.apply(to: beta), dp.type)))
        default:
            fatalError()
        }
    }
}
