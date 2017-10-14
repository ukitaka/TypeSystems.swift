//
// Created by ukitaka on 2017/10/14.
//

public extension Parser {
    public func or(_ other: @autoclosure @escaping () -> Parser<A>) -> Parser<A> {
        return Parser<A> { input in
            switch self.parse(input) {
            case let .success(a, remaining):
                return .success(a, remaining)
            case .failure:
                switch other().parse(input) {
                case let .success(a, remaining):
                    return .success(a, remaining)
                case .failure:
                    return .failure(.error("or error"))
                }
            }
        }
    }
}
