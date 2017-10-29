//
// Created by ukitaka on 2017/10/28.
//

public indirect enum Term {
    public typealias ConformedProtocol = Term

    case protocolDecl(Name, [MethodSignature])
    case structDecl(Name, ConformedProtocol?, [MethodSignature: MethodBody])
    case `var`(Name)
    case letDecl(Name, Type, Term)
    case methodCallExpr(Term, Name, Term)
}

public extension Term {
    var isProtocolDecl: Bool {
        if case .protocolDecl = self {
            return true
        } else {
            return false
        }
    }
}

public extension Term {
    public struct Method {
        let signature: MethodSignature
        let body: MethodBody
    }
    public struct MethodSignature {
        let methodName: Name
        let argName: Name
        let type: Type

        public init(methodName: Name, argName: Name, argType: Type, retType: Type) {
            self.methodName = methodName
            self.argName = argName
            self.type = .func(argType, retType)
        }
    }

    public struct MethodBody {
        // TODO
    }
}

extension Term: Equatable {
    public static func ==(lhs: Term, rhs: Term) -> Bool {
        switch (lhs, rhs) {
        case let (.protocolDecl(name1, methods1), .protocolDecl(name2, methods2)):
            return name1 == name2 && methods1 == methods2
        case let (.structDecl(name1, proto1, methods1), .structDecl(name2, proto2, methods2)):
            return name1 == name2 && proto1 == proto2 && methods1.keys == methods2.keys //TODO: method body
        case let (.letDecl(name1, type1, body1), .letDecl(name2, type2, body2)):
            return name1 == name2 && type1 == type2 && body1 == body2
        case let (.methodCallExpr(term1, name1, arg1), .methodCallExpr(term2, name2, arg2)):
            return name1 == name2 && term1 == term2 && arg1 == arg2
        case let (.var(name1), .var(name2)):
            return name1 == name2
        default:
            return false
        }
    }
}

extension Term.MethodSignature: CustomStringConvertible {
    public var description: String {
        guard case let .func(arg, ret) = type else {
            fatalError()
        }
        return "func \(methodName)(\(argName): \(arg)) -> \(ret)"
    }
}

extension Term.MethodSignature: Hashable {
    public var hashValue: Int {
        return self.description.hashValue
    }

    public static func ==(lhs: Term.MethodSignature, rhs: Term.MethodSignature) -> Bool {
        return lhs.methodName == rhs.methodName
                && lhs.argName == rhs.argName
                && lhs.type == rhs.type
    }
}

extension Term.Method: Equatable {
    public static func ==(lhs: Term.Method, rhs: Term.Method) -> Bool {
        return lhs.signature == rhs.signature
    }
}
