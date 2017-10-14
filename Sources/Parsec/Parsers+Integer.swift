//
// Created by Yuki Takahashi on 2017/10/14.
//

public extension Parsers {
    public static func digit() -> Parser<String> {
        let d = Parsers.string
        return d("0") <|> d("1") <|> d("2") <|>
                d("3") <|> d("4") <|> d("5") <|>
                d("6") <|> d("7") <|> d("8") <|> d("9")
    }

    public static func digitHead() -> Parser<String> {
        let d = Parsers.string
        return d("1") <|> d("2") <|>
                d("3") <|> d("4") <|> d("5") <|>
                d("6") <|> d("7") <|> d("8") <|> d("9")
    }

    public static func integerZero() -> Parser<Int> {
        return Parsers.string("0").map { _ in 0 }
    }

    public static func integer() -> Parser<Int> {
        return integerZero() <|> (digitHead() <**> digit().many())
            .mapResult { (tuple, remaining) in
                if let int = Int(tuple.0 + tuple.1.joined()) {
                    return .success(int, remaining)
                } else {
                    return .failure(.error("failed to parse integer"))
                }
            }
    }
}
