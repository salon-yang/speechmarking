import Foundation

public extension URL {

    /// Initialize URL from Moya's `TargetType`.
    init<T: TargetType>(target: T) {
        // When a TargetType's path is empty, URL.appendingPathComponent may introduce trailing /, which may not be wanted in some cases
        // See: https://github.com/Moya/Moya/pull/1053
        // And: https://github.com/Moya/Moya/issues/1049
        
        //原库写法
//        if target.path.isEmpty {
//            self = target.baseURL
//        } else {
//            self = target.baseURL.appendingPathComponent(target.path)
//        }
        //只要path
        if target.path.isEmpty {
            //self = target.baseURL
            self = URL(string: target.path)!
            print(self)
        } else {
            //self = target.baseURL.appendingPathComponent(target.path)
            self = URL(string: target.path)!
            print(self)
        }
    }
}
