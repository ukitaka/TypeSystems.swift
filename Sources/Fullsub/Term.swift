//
// Created by Yuki Takahashi on 2017/10/24.
//


public indirect enum Term {
    case `var`(VarName)
    case abs(VarName, Type, Term)
    case app(Term, Term)
    case record([Label: Term])
    case proj(Term, Label)
}

// MARK: -

extension Term: Equatable {
    public static func ==(lhs: Term, rhs: Term) -> Bool {
        switch(lhs, rhs) {
        case let (.var(name1), .var(name2)):
            return name1 == name2
        case let (.abs(name1, type1, term1), .abs(name2, type2, term2)):
            return name1 == name2 && type1 == type2 && term1 == term2
        case let (.app(fun1, arg1), .app(fun2, arg2)):
            return fun1 == fun2 && arg1 == arg2
        case let (.record(elements1), .record(elements2)):
            return elements1 == elements2
        case let (.proj(term1, label1), .proj(term2, label2)):
            return term1 == term2 && label1 == label2
        default:
            return false
        }
    }
}
