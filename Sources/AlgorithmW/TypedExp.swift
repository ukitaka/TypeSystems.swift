//
// Created by ukitaka on 2017/10/21.
//

import Utils

public struct TypedExp {
    let type: Type
    let exp: Exp
}

// MARK: - Equatable

extension TypedExp: Equatable {
    public static func ==(lhs: TypedExp, rhs: TypedExp) -> Bool {
        return lhs.type == rhs.type && lhs.exp == rhs.exp
    }
}
