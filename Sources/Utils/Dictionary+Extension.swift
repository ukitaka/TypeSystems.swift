//
// Created by Yuki Takahashi on 2017/10/18.
//

public extension Dictionary {
    public func removing(key: Key) -> Dictionary<Key, Value> {
        var dictionary = self
        dictionary.removeValue(forKey: key)
        return dictionary
    }

    public func removing(keys: [Key]) -> Dictionary<Key, Value> {
        var dictionary = self
        for key in keys {
            dictionary.removeValue(forKey: key)
        }
        return dictionary
    }

    public init(keys: [Key], values: [Value]) {
        precondition(keys.count == values.count)
        let count = keys.count
        var dictionary: Dictionary<Key, Value> = [:]

        for i in 0..<count {
            dictionary[keys[i]] = values[i]
        }

        self = dictionary
    }
}