//
// Created by Yuki Takahashi on 2017/10/28.
//

public extension Parsers {
    public static func whiteSpace()  -> Parser<Void> {
        return (Parsers.string(" ")
                <|> Parsers.string("\n")
                <|> Parsers.string("\t")).discard()
    }

    public static func whiteSpaces()  -> Parser<Void> {
        return whiteSpace().many().discard()
    }
}
