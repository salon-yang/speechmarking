//
//  KeyValuePersistence.swift
//  YunTrans
//
//  Created by tony on 2019/10/25.
//  Copyright © 2019 liip. All rights reserved.
//

import Foundation
class ArchiveUtil{
    class func archiveObject(object:Any, forKey:String){
        let objectData = NSKeyedArchiver.archivedData(withRootObject: object)
        let defaults = UserDefaults.standard
        // 持久化
        defaults.set(objectData, forKey: forKey)
        let success = defaults.synchronize()
    }

    class func readObjectFromArchive(forKey:String) -> Any?{
        let data = UserDefaults.standard.object(forKey: forKey)
        guard data != nil else{
            return nil
        }
        return NSKeyedUnarchiver.unarchiveObject(with: data as! Data)

    }
    
}
