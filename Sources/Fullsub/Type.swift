//
// Created by Yuki Takahashi on 2017/10/24.
//

public indirect enum Type {
    case top
    case `func`(Type, Type)
    case record([Label: Type])
}

// MARK: - Equatable

extension Type: Equatable {
    public static func ==(lhs: Type, rhs: Type) -> Bool {
        switch (lhs, rhs) {
        case (.top, .top):
            return true
        case let (.func(arg1, ret1), .func(arg2, ret2)):
            return arg1 == arg2 && ret1 == ret2
        case let (.record(types1), .record(types2)):
            return types1 == types2
        default:
            return false
        }
    }
}

// MARK: - subtype

public extension Type {
    public func isSubType(of type: Type) -> Bool {
        switch (self, type) {
        case (_, .top):
            return true
        case let (.func(argSub, retSub), .func(argSup, retSup)):
            return argSup.isSubType(of: argSub) && retSub.isSubType(of: retSup)
        case let (.record(typesSub), .record(typesSup)):
            return typesSup.reduce(true) { (isSubType, tuple: (Label, Type)) -> Bool in
                let (label, superType) = tuple
                if let subType = typesSub[label] {
                    return isSubType && superType.isSubType(of: subType)
                }
                return true
            }
        default:
            return false

        }
    }
}
