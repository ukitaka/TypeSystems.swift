//
// Created by Yuki Takahashi on 2017/10/28.
//

import Foundation

public extension Parsers {
    public static func skipUntil(_ str: String) -> Parser<Void> {
        return Parser<Void> { input in
            var input = input
            while input.hasPrefix(str) == false {
                input = input.removingFirst()
                if input.isEmpty {
                    return .success((), input)
                }
            }
            return .success((), input)
        }
    }
}
