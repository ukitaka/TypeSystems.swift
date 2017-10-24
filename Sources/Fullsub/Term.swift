//
// Created by Yuki Takahashi on 2017/10/24.
//


public indirect enum Term {
    case `var`(VarName)
    case abs(VarName, Type, Term)
    case app(Term, Term)
    case record([Label: Term])
    case proj(Label, Label)
}
