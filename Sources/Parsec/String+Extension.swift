//
// Created by ukitaka on 2017/10/13.
//

extension String {
    func removingFirst() -> String {
        var str = self
        str.removeFirst()
        return str
    }

    func removing(head: String) -> String {
        var str = self
        str.removeFirst(head.characters.count)
        return str
    }
}
