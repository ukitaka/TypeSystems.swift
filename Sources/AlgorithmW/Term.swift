//
// Created by ukitaka on 2017/10/12.
//

public indirect enum Term {
    case `var`(String)
    case literal(Literal)
    case abs(String, Term)
    case app(Term, Term)
    case `let`(String, Term, Term)
}
