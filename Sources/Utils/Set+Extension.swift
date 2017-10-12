//
// Created by ukitaka on 2017/10/12.
//

public extension Set {
    public func toArray() -> Array<Element> {
        return map { $0 }
    }

    public static func ∩(lhs: Set<Element>, rhs: Set<Element>) -> Set<Element> {
        return lhs.intersection(rhs)
    }

    public static func ∪(lhs: Set<Element>, rhs: Set<Element>) -> Set<Element> {
        return lhs.union(rhs)
    }

    public static func /(lhs: Set<Element>, rhs: Set<Element>) -> Set<Element> {
        return lhs.subtracting(rhs)
    }

    public static func ∈(lhs: Element, rhs: Set<Element>) -> Bool {
        return rhs.contains(lhs)
    }

    public static func ∋(lhs: Set<Element>, rhs: Element) -> Bool {
        return lhs.contains(rhs)
    }

    public static func ∉(lhs: Element, rhs: Set<Element>) -> Bool {
        return !rhs.contains(lhs)
    }

    public static func ∌(lhs: Set<Element>, rhs: Element) -> Bool {
        return !lhs.contains(rhs)
    }

}
