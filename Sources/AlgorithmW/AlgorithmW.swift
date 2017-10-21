//
// Created by ukitaka on 2017/10/18.
//

public struct AlgorithmW { }

public extension AlgorithmW {
    func w(p: TypedPrefix, f: Exp) -> (Substitution, TypedExp) {
        switch f {
        case let .var(x):
            if let member = p[x], p.isActive(member: .abs(x)) || p.isActive(member: .fix(x)) {
                return (Substitution.empty(), TypedExp(exp: .var(x), type: member.type))
            } else if p.isActive(member: .let(x)) {
                return (Substitution.empty(), TypedExp(exp: .var(x), type: Type.freshVar()))
            }
            fatalError()
        default:
            fatalError()
        }
    }
}
