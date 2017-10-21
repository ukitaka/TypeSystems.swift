//
// Created by ukitaka on 2017/10/13.
//

public struct VarName {
    private static var counter: Int = 0

    public let name: String

    public init(name: String) {
        self.name = name
    }

    init() {
        VarName.counter += 1
        self.name = "X\(VarName.counter)"
    }

    public static func fresh() -> VarName {
        return VarName()
    }
}

// MARK: - Equatable

extension VarName: Equatable {
    public static func ==(lhs: VarName, rhs: VarName) -> Bool {
        return lhs.name == rhs.name
    }
}

// MARK: - Hashable

extension VarName: Hashable {
    public var hashValue: Int {
        return name.hashValue
    }
}

// MARK: - ExpressibleByStringLiteral

extension VarName: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.name = value
    }

    public init(unicodeScalarLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.name = value
    }
}

// MARK: - CustomStringConvertible

extension VarName: CustomStringConvertible {
    public var description: String {
        return name
    }
}
