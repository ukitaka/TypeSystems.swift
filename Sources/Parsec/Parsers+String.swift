//
// Created by ukitaka on 2017/10/13.
//

import Foundation

public extension Parsers {
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

    public static func alphabet() -> Parser<Character> {
         return Parser<Character> { input in
            if let first = input.unicodeScalars.first, CharacterSet.lowercaseLetters.contains(first) || CharacterSet.uppercaseLetters.contains(first) {
                return .success(Character(first), input.removingFirst()) //TODO: あとで直す。unicodeScalaとCharactersがごっちゃ。
            } else {
                return .failure(.error("input doesn't has alphabet name"))
            }
        }
    }

    public static func alphabets() -> Parser<String> {
        return alphabet().many().map{ String($0) }
    }
}
