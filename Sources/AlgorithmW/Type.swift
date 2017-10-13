//
// Created by ukitaka on 2017/10/13.
//

public indirect enum Type {
    case int
    case bool
    case `func`(Type, Type)
    case typeVar(String)
}
