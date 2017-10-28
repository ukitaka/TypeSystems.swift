//
// Created by ukitaka on 2017/10/28.
//

public func extends<A, B, C>(_ lhs: (A, B), rhs: C) -> (A, B, C) {
    return (lhs.0, lhs.1, rhs)
}

public func extends<A, B, C, D>(_ lhs: (A, B, C), rhs: D) -> (A, B, C, D) {
    return (lhs.0, lhs.1, lhs.2, rhs)
}

public func extends<A, B, C, D, E>(_ lhs: (A, B, C, D), rhs: E) -> (A, B, C, D, E) {
    return (lhs.0, lhs.1, lhs.2, lhs.3, rhs)
}

public func flatten<A,B, C>(_ tuple: ((A, B), C)) -> (A, B, C) {
    return (tuple.0.0, tuple.0.1, tuple.1)
}

public func flatten<A,B, C, D>(_ tuple: (((A, B), C), D)) -> (A, B, C, D) {
    return (tuple.0.0.0, tuple.0.0.1, tuple.0.1, tuple.1)
}
