//
// Created by Yuki Takahashi on 2017/10/24.
//

public typealias Label = String

public typealias VarName = String

public func type(of term: Term) -> Type {
    func type(of term: Term, context: Context) -> Type {
        fatalError()
    }
    return type(of: term, context: Context())
}
