//
// Created by ukitaka on 2017/10/12.
//

precedencegroup CompositionPrecedence {
    associativity: right
    higherThan: BitwiseShiftPrecedence
}

precedencegroup PrecedenceLeft {
    associativity: left
}

infix operator ∈
infix operator ∋
infix operator ∉
infix operator ∌
infix operator ↦
infix operator →
infix operator • : CompositionPrecedence
infix operator ⊢
infix operator ∪: PrecedenceLeft
infix operator ∩: PrecedenceLeft
