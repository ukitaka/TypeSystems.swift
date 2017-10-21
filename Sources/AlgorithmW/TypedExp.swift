//
// Created by ukitaka on 2017/10/21.
//

import Utils

public struct TypedExp {
    let exp: Exp
    let type: Type
}

// MARK: - Equatable

extension TypedExp: Equatable {
    public static func ==(lhs: TypedExp, rhs: TypedExp) -> Bool {
        return lhs.type == rhs.type && lhs.exp == rhs.exp
    }
}
