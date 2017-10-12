//
// Created by ukitaka on 2017/10/12.
//

indirect enum Term {
    case `var`(String)
    case literal(String)
    case abs(String, Term)
    case app(Term, Term)
    case `let`(String, Term, Term)
}
