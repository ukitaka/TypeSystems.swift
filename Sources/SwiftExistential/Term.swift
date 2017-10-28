//
// Created by ukitaka on 2017/10/28.
//

public indirect enum Term {
    public typealias ConformedProtocol = Term

    case protocolDecl(Name, [Method])
    case structDecl(Name, ConformedProtocol?, [Method: MethodBody])
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
        let methodName: Name
        let argName: Name
        let type: Type
    }

    public struct MethodBody {
        // TODO
    }
}

extension Term.Method: CustomStringConvertible {
    public var description: String {
        guard case let .func(arg, ret) = type else {
            fatalError()
        }
        return "func \(methodName)(\(argName): \(arg)) -> \(ret)"
    }
}

extension Term.Method: Hashable {
    public var hashValue: Int {
        return self.description.hashValue
    }

    public static func ==(lhs: Term.Method, rhs: Term.Method) -> Bool {
        return lhs.methodName == rhs.methodName
                && lhs.argName == rhs.argName
                && lhs.type == rhs.type
    }
}
