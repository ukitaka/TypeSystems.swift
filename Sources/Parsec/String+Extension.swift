//
// Created by ukitaka on 2017/10/13.
//

public extension String {
    public func removing(head: String) -> String {
        var str = self
        str.removeFirst(head.characters.count)
        return str
    }
}
