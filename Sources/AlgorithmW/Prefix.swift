//
// Created by Yuki Takahashi on 2017/10/20.
//

import Utils

public struct Prefix {
    public enum Member {
        case `let`(VarName)
        case fix(VarName)
        case abs(VarName)
    }

    let members: [Member]
}

// MARK: -

extension Prefix.Member {
    public var varName: VarName {
        switch self {
        case let .let(varName):
            return varName
        case let .fix(varName):
            return varName
        case let .abs(varName):
            return varName
        }
    }
}

extension Prefix.Member: Equatable {
    public static func ==(lhs: Prefix.Member, rhs: Prefix.Member) -> Bool {
        switch (lhs, rhs) {
        case let (.let(varName1), .let(varName2)):
            return varName1 == varName2
        case let (.fix(varName1), .fix(varName2)):
            return varName1 == varName2
        case let (.abs(varName1), .abs(varName2)):
            return varName1 == varName2
        default:
            return false
        }
    }
}
