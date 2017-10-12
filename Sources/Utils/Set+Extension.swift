//
// Created by ukitaka on 2017/10/12.
//

public extension Set {
    public func toArray() -> Array<Element> {
        return map { $0 }
    }
}
