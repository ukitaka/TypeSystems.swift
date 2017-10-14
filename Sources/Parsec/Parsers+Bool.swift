//
// Created by Yuki Takahashi on 2017/10/14.
//

public extension Parsers {
    static func trueParser()  -> Parser<Bool> {
        return Parsers.string("true").map { _ in true }
    }

    static func falseParser()  -> Parser<Bool> {
        return Parsers.string("false").map { _ in false }
    }

    public static func bool() -> Parser<Bool> {
        return trueParser() <|> falseParser()
    }
}
