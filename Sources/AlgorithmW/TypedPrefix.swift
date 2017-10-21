//
// Created by ukitaka on 2017/10/21.
//

public struct TypedPrefix {
    public enum TypedMember {
        case `let`(VarName, Type)
        case fix(VarName, Type)
        case abs(VarName, Type)
    }

    let members: [TypedMember]

    init() {
        members = []
    }

    public init(prefix: Prefix) {
        self.members = prefix.members.map(TypedMember.init)
    }

    public func isActive(member: Prefix.Member) -> Bool {
        return members.filter { $0.varName == member.varName }.last?.untyped() == member
    }

    public func isActive(member: TypedMember) -> Bool {
        return members.filter { $0.varName == member.varName }.last == member
    }

    public subscript(varName: VarName) -> TypedMember? {
        return members.first { $0.varName == varName }
    }
}

// MARK: -

extension TypedPrefix.TypedMember {

    public func untyped() -> Prefix.Member {
        switch self {
        case let .let(varName, _):
            return .let(varName)
        case let .fix(varName, _):
            return .fix(varName)
        case let .abs(varName, _):
            return .abs(varName)
        }
    }

    public init(member: Prefix.Member) {
        switch member {
        case let .let(varName):
            self = .let(varName, Type.freshVar())
        case let .fix(varName):
            self = .fix(varName, Type.freshVar())
        case let .abs(varName):
            self = .abs(varName, Type.freshVar())
        }
    }

    public var varName: VarName {
        switch self {
        case let .let(varName, _):
            return varName
        case let .fix(varName, _):
            return varName
        case let .abs(varName, _):
            return varName
        }
    }

    public var type: Type {
        switch self {
        case let .let(_, type):
            return type
        case let .fix(_, type):
            return type
        case let .abs(_, type):
            return type
        }
    }
}

extension TypedPrefix.TypedMember: Equatable {
    public static func ==(lhs: TypedPrefix.TypedMember, rhs: TypedPrefix.TypedMember) -> Bool {
        switch (lhs, rhs) {
        case let (.let(varName1, type1), .let(varName2, type2)):
            return varName1 == varName2 && type1 == type2
        case let (.fix(varName1, type1), .fix(varName2, type2)):
            return varName1 == varName2 && type1 == type2
        case let (.abs(varName1, type1), .abs(varName2, type2)):
            return varName1 == varName2 && type1 == type2
        default:
            return false
        }
    }
}