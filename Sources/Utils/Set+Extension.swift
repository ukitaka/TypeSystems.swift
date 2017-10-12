//
// Created by ukitaka on 2017/10/12.
//

public extension Set {
    public func toArray() -> Array<Element> {
        return map { $0 }
    }

    public static func /<T>(lhs: Set<T>, rhs: Set<T>) -> Set<T> {
        return lhs.subtracting(rhs)
    }

    public static func ∈<T>(lhs: T, rhs: Set<T>) -> Bool {
        return rhs.contains(lhs)
    }
}
