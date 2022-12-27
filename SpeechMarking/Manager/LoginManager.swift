//
//  Loginmanage.swift
//  SpeechMarking
//
//  Created by Crabbit on 2022/6/20.
//

import Foundation
import Alamofire
import Foundation
import SwiftyJSON
import Moya
import PromiseKit
import RxSwift


class LoginManager:ObservableObject{
    @Published var userinfo : MainResp.loginResp?
    //static var userProfileShowingText = BehaviorRelay(value:"请先登录")
    static var userInfo:MainResp.loginResp?{
        willSet{
            guard newValue != nil else {
                //YuntransLoginManager.userProfileShowingText.accept("请先登录")
                return
            }
        }
    }
    static var isloginstate = false
    
//    class func makeProfileShowText(userinfo newValue:MainResp.loginResp)->String{
//        var textSeq = [String]()
//        if !(newValue.name.elementsEqual("未设置") ?? true){
//            textSeq.append(newValue.name)
//        }
//        textSeq.append(newValue.username)
//        let text = textSeq.joined(separator: "，")
//
//        return text
//    }
    /**
     使用用户名密码登录，登录失败会弹出提示
     - Parameter username: 用户名
     - Parameter password: 用户密码
     */
    
    class func login(username: String, password: String)-> PMKFinalizer{
        return firstly { () -> Promise<JSON> in
            return MainService.promise(.login(username: username, password: password))
        }.done { (json) in
            print("登录：\(json)")
            Logincontroller.shared.loginstatu = true
            Logincontroller.shared.loginmessage = json["message"].description
            //self.updateloginstatu(statu: json["message"].description)
            if json["code"] == 200{
                isloginstate = true
                TaskManager.shared.loadtasklist(json: json["data"])
                Logincontroller.shared.loginstatu = true
                userInfo = try? JSONDecoder().decode(MainResp.loginResp.self, from: "\(json)".data(using: .utf8)!)
                //EWToast.showCenterWithText(text: "登录成功",duration: 3.0)

                try loginConfig(json: json)
            }
            else{
                //EWToast.showCenterWithText(text: json["message"].description,duration: 3.0)
                print(json["message"])
            }

        }.catch { (error) in
            print(error.localizedDescription)
        }
    }
    

    
    /**
     使用手机号验证码登录，登录失败会弹出提示
     - Parameter phone: 手机号
     - Parameter verifycode: 验证码
     */
//    class func login(phone: String, verifycode: String)-> PMKFinalizer{
//        return firstly { () -> Promise<JSON> in
//            return MainService.promise(.msglogin(phone: phone, verifycode: verifycode))
//        }.done { (json) in
//            if json["result"].description=="null"{
//                LoginManager.shared.isloginsuccess = "登录成功"
//            }
//            else{
//                LoginManager.shared.isloginsuccess = json["result"].description
//            }
//            print("登录：\(json)")
//            try loginConfig(json: json)
//
//        }.catch { (error) in
//            print(error)
//             //EWToast.showCenterWithText(text: "\(error.localizedDescription)")
//        }
//    }
    
    /**
     根据持久化的Session自动登录
     */
//    class func autoLogin() -> PMKFinalizer{
//        return firstly { () -> Promise<JSON> in
//            return MainService.promise(.auto)
//        }.done { (json) in
//            print("自动登录：\(json)")
//            if json.dictionaryObject?["return_code"] as? String == "ERROR"{
//                print("自动登录失败！")
//            }else{
//                try loginConfig(json: json)
//            }
//        }.catch { (error) in
//            //EWToast.showCenterWithText(text: "\(error.localizedDescription)")
//        }
//    }
    
    /**
     多种登录方式通用验证方法
     - Parameter json: 服务器返回的json
     */
    class private func loginConfig(json:JSON) throws{
        if json.dictionaryObject?["code"] as? String == "SUCCESS"{
            
            if let loginInfo = try? JSONDecoder().decode(MainResp.loginResp.self, from: "\(json)".data(using: .utf8)!){
                userInfo = loginInfo
                print(userInfo)
                MainService.saveCookies()
                //EWToast.showCenterWithText(text: "欢迎\((userInfo?.username)!)")
            }else{
                throw SwiftyJSONError.unsupportedType
            }

        }else{
            let error_msg = json.dictionaryObject?["return_msg"] as? String
            //EWToast.showCenterWithText(text: error_msg ?? "登录失败，原因未知" )
        }
    }
    
    //register
    class func register(username: String, password: String){
        MainService.promise(.register(username: username, password: password))
        .done { (json) in
            
            
            print("注册：\(json)")
            if json["code"] == 200{
                Logincontroller.shared.registermessage = json["message"].description
                Logincontroller.shared.registerstatu = true
                userInfo = try? JSONDecoder().decode(MainResp.loginResp.self, from: "\(json)".data(using: .utf8)!)
                //EWToast.showCenterWithText(text: "登录成功",duration: 3.0)

                try loginConfig(json: json)
            }
            else{
                Logincontroller.shared.registermessage = json["message"].description
                //EWToast.showCenterWithText(text: json["message"].description,duration: 3.0)
                print(json["message"])
            }
            //EWToast.showCenterWithText(text: "\(username)注册成功")
            //try loginConfig(json: json)

        }.catch { (error) in
            print(error)
             //EWToast.showCenterWithText(text: "\(error.localizedDescription)")
        }
    }
    
    /**
     检查是否已经登录
     */
    class func isLogin() -> Bool{
        //print(YuntransLoginManager.userInfo?.username == "18468026970")
        return LoginManager.userInfo != nil
        //return isloginstate
    }
    
    /**
     检查是否填写过个人信息
     */
//    class func isSignin() -> Bool{
//        return YuntransLoginManager.userInfo?.name.count != 0
//    }
//
//    class func isApple() -> Bool{
//        return YuntransLoginManager.userInfo?.username.elementsEqual("apple") ?? true
//    }
    

    
}
