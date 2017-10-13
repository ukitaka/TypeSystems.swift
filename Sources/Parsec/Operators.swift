//
// Created by ukitaka on 2017/10/13.
//

precedencegroup ParserMonadicPrecedenceRight {
    associativity: right
    lowerThan: LogicalDisjunctionPrecedence
    higherThan: AssignmentPrecedence
}

precedencegroup ParserMonadicPrecedenceLeft {
    associativity: left
    lowerThan: LogicalDisjunctionPrecedence
    higherThan: AssignmentPrecedence
}

precedencegroup ParserAlternativePrecedence {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
    lowerThan: ComparisonPrecedence
}

precedencegroup ParserApplicativePrecedence {
    associativity: left
    higherThan: ParserAlternativePrecedence
    lowerThan: NilCoalescingPrecedence
}

precedencegroup ParserApplicativeSequencePrecedence {
    associativity: left
    higherThan: ParserApplicativePrecedence
    lowerThan: NilCoalescingPrecedence
}

infix operator <^> : ParserApplicativePrecedence

infix operator <*> : ParserApplicativePrecedence

infix operator <* : ParserApplicativeSequencePrecedence

infix operator *> : ParserApplicativeSequencePrecedence

infix operator <|> : ParserAlternativePrecedence

infix operator >>- : ParserMonadicPrecedenceLeft

infix operator -<< : ParserMonadicPrecedenceRight

infix operator >-> : ParserMonadicPrecedenceRight

infix operator <-< : ParserMonadicPrecedenceRight
