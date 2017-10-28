//
// Created by ukitaka on 2017/10/28.
//

public indirect enum Term {
    public typealias ConformedProtocol = Term

    case protocolDecl(Name, ConformedProtocol?, [Method])
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
        let name: Name
        let type: Type
    }

    public struct MethodBody {
        // TODO
    }
}

extension Term.Method: CustomStringConvertible {
    public var description: String {
        return "func \(name): \(type)"
    }
}

extension Term.Method: Hashable {
    public var hashValue: Int {
        return self.description.hashValue
    }

    public static func ==(lhs: Term.Method, rhs: Term.Method) -> Bool {
        return lhs.name == rhs.name && lhs.type == rhs.type
    }
}
