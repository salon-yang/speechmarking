//
//  VoiceData.swift
//  YunLingListenTrans
//
//  Created by wqd on 2020/6/22.
//  Copyright © 2020 wqd. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

//@objc(VoiceData)
public class VoiceData : NSManagedObject, Identifiable {
    
    @NSManaged public var name: String?
    @NSManaged public var url: URL?
    @NSManaged public var conductWay: Bool
    @NSManaged public var date: Date?
    @NSManaged public var duration: Int16
}

extension VoiceData {
    
    static func  getAllCourses() -> NSFetchRequest<VoiceData> {
        let request : NSFetchRequest<VoiceData> = NSFetchRequest<VoiceData>(entityName: "VoiceData")
        //VoiceData.fetchRequest() as! NSFetchRequest<VoiceData>
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
