//
// Created by Yuki Takahashi on 2017/10/20.
//

public struct PrefixedExp {
    let prefix: Prefix
    let exp: Exp

    public init(prefix: Prefix, exp: Exp) {
        self.prefix = prefix
        self.exp = exp
    }
}
