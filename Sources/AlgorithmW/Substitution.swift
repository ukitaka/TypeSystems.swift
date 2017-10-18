//
// Created by Yuki Takahashi on 2017/10/18.
//

import Utils

public struct Substitution {
    private let map: [VarName: Type]

    public func removing(varName: VarName) -> Substitution {
        return Substitution(map: self.map.removing(key: varName))
    }
}
