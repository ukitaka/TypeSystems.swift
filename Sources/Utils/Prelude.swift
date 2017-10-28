//
// Created by Yuki Takahashi on 2017/10/28.
//

public func const<A, B>(_ a: A) -> (B) -> A {
    return { _ in a }
}
