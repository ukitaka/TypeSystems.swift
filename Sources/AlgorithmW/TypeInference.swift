//
// Created by ukitaka on 2017/10/13.
//


func typeInferenceLiteral(literal: Literal) -> (Substitution, Type) {
    switch literal {
    case .bool:
        return (.empty(), .bool)
    case .int:
        return (.empty(), .int)
    }
}

func typeInferenceTerm(env: TypeEnv, term: Term) -> (Substitution, Type) {
    fatalError()
}

public func typeInference(env: TypeEnv, term: Term) -> Type {
    let (substitution, type) = typeInferenceTerm(env: env, term: term)
    return substitution.apply(to: type)
}
