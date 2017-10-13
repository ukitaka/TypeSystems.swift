//
// Created by ukitaka on 2017/10/12.
//

public indirect enum Term {
    case `var`(VarName)
    case literal(Literal)
    case abs(VarName, Term)
    case app(Term, Term)
    case `let`(VarName, Term, Term)
}
