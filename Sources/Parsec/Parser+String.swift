//
// Created by ukitaka on 2017/10/13.
//

public extension Parser {
    public static func char(_ char: Character) -> Parser<Character> {
        return Parser<Character> { input in
            if input.characters.first == char {
                return .success(char, input.removingFirst())
            } else {
                return .failure(.error("input doesn't has prefix character'\(char)'"))
            }
        }
    }

    public static func string(_ str: String) -> Parser<String> {
        return Parser<String> { input in
            if input.hasPrefix(str) {
                return .success(str, input.removing(head: str))
            } else {
                return .failure(.error("input doesn't has prefix '\(str)'"))
            }
        }
    }
}
