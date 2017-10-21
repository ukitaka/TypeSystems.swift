//
// Created by ukitaka on 2017/10/19.
//

import Utils

public struct AlgorithmU { }

public extension AlgorithmU {

    public static func mostGeneralUnifier(_ type1: Type, _ type2: Type) -> Substitution {
        switch (type1, type2) {
        case let (.typeVar(varName), _):
            return Substitution(varName: varName, type: type2)
        case let (_, .typeVar(varName)):
            return Substitution(varName: varName, type: type1)
        case let (.func(arg1, ret1), .func(arg2, ret2)):
            return mostGeneralUnifier(arg1, arg2) ∪ mostGeneralUnifier(ret1, ret2)
        case (.int, .int):
            return Substitution()
        case (.bool, .bool):
            return Substitution()
        default:
            fatalError("error") //TODO: error handling
        }
    }
}
