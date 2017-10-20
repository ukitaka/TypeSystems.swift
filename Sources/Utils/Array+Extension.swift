//
// Created by ukitaka on 2017/10/14.
//

public extension Array {
    public static func cons(element: Element, array: [Element]) -> [Element] {
        return array.cons(element: element)
    }

    public func cons(element: Element) -> [Element] {
        var array = self
        array.insert(element, at: 0)
        return array
    }

    public func appending(element: Element) -> [Element] {
        var array = self
        array.append(element)
        return array
    }
}
