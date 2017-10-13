//
// Created by ukitaka on 2017/10/13.
//

public struct VarName {
    public let name: String
}

extension VarName: Equatable {
    public static func ==(lhs: VarName, rhs: VarName) -> Bool {
        return lhs.name == rhs.name
    }
}

extension VarName: Hashable {
    public var hashValue: Int {
        return name.hashValue
    }
}

extension VarName: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.name = value
    }

    public init(unicodeScalarLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.name = value
    }
}
