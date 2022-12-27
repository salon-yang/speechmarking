//
//  YuntransVersionController.swift
//  YunTrans
//
//  Created by tony on 2020/1/3.
//  Copyright © 2020 liip. All rights reserved.
//

import Foundation
import UIKit

//var isversionupdate = false

var updateurl = "https://apps.apple.com/cn/app/xiaoyutag/id6443665576"
var appversion = "1.3.4"

class VersionController{
    //应用程序信息
    private static let infoDictionary = Bundle.main.infoDictionary!
    static let appDisplayName = infoDictionary["CFBundleDisplayName"] //程序名称
    static let majorVersion = infoDictionary["CFBundleShortVersionString"]//主程序版本号
    static let minorVersion = infoDictionary["CFBundleVersion"]//版本号（内部标示）
    static let appVersion = majorVersion as! String
    
    //设备信息
    static let iosVersion = UIDevice.current.systemVersion //iOS版本
    static let identifierNumber = UIDevice.current.identifierForVendor //设备udid
    static let systemName = UIDevice.current.systemName //设备名称
    static let model = UIDevice.current.model //设备型号
    static let localizedModel = UIDevice.current.localizedModel //设备区域化型号如A1533
    
    class func getVersion(){
         
        //打印信息
        print("程序名称：\(appDisplayName)")
        print("主程序版本号：\(appVersion)")
        print("内部版本号：\(minorVersion)")
        print("iOS版本：\(iosVersion)")
        print("设备udid：\(identifierNumber)")
        print("设备名称：\(systemName)")
        print("设备型号：\(model)")
        print("设备区域化型号：\(localizedModel)")
    }

//    class func checkVersion() -> Bool{
//        print(identifierNumber)
//        var isversionupdate = false
//        MainService.promise(.query_apkcode_APPLE).done { (json) in
//
//            print("\(json.description)")
//            //print(appVersion)
//            if let result = try? JSONDecoder().decode(MainResp.query_apkcode_APPLEResp.self, from: json.data){
//                if compareVersion(nowVersion: appversion, newVersion: result.version_code){
//                    isversionupdate = true
//                    print("需要更新")
//                    updateurl = result.apk_url
//                }
//                else{
//                    isversionupdate = false
//                    EWToast.showCenterWithText(text: "已是最新版本")
//
//                }
//            }
//        }
//        return isversionupdate
//
//    }
    class func checkVersion(outOfDateCallback:@escaping (_ desp : String, _ url : String)->()){
        let callBack = outOfDateCallback
        print(identifierNumber)
        MainService.promise(.query_apkcode_APPLE).done { (json) in
            print("\(json.description)")
            print(appversion)
            if let result = try? JSONDecoder().decode(MainResp.query_apkcode_APPLEResp.self, from: json.data){
                if compareVersion(nowVersion: appversion, newVersion: result.version_code){
                    print("需要更新")
                    callBack(result.description, result.apk_url)
                }
                else{
                    //EWToast.showCenterWithText(text: "已是最新版本")
                }
            }
        }
        
    }
    
}

func compareVersion(nowVersion:String,newVersion:String) -> Bool {
    
    let nowArray = nowVersion.split(separator: ".")
    
    let newArray = newVersion.split(separator: ".")
    
    var nowVersions = nowVersion
    
    var newVersions = newVersion
    
    if nowArray.count == 2{
        nowVersions = nowVersion+".0"
    }
    
    if newArray.count == 2{
        newVersions = newVersion+".0"
    }
    
    let nowArrays = nowVersions.split(separator: ".")
    
    let newArrays = newVersions.split(separator: ".")
    print(nowArrays)
    print(newArrays)
    
    for index in 0...nowArrays.count - 1 {
        
        let first = nowArrays[index]
        let second = newArrays[index]
        if Int(first)! < Int(second)!  {
            return true
        }
        if Int(first)! > Int(second)!  {
            return false
        }
    }
    
    return false
}
