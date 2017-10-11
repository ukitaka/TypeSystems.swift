pub enum Term {
    Var(String),                      // x
    Lit(String),                      // 1, true
    Abs(String, Box<Term>),           // λ x. t
    App(Box<Term>, Box<Term>),        // (t, t)
    Let(String, Box<Term>, Box<Term>) // let x = t1 in t2
}
