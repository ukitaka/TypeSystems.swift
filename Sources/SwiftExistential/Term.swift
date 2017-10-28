//
// Created by ukitaka on 2017/10/28.
//

public indirect enum Term {
    public typealias ConformedProtocol = Term

    case protocolDecl(Name, [MethodSignature])
    case structDecl(Name, ConformedProtocol?, [MethodSignature: MethodBody])
    case letDecl(Name, Term)
    case methodCallExpr(Term, Name)
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
