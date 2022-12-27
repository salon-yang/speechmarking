//
//  Logincontroller.swift
//  SpeechMarking
//
//  Created by Crabbit on 2022/9/6.
//
//
//  LoginManager.swift
//  YunTrans_SwiftUI
//
//  Created by Crabbit on 2021/7/5.
//

import Foundation
class Logincontroller:ObservableObject{
    @Published var loginmessage : String = "正在登录"
    @Published var loginstatu : Bool = false
    @Published var registermessage : String = "正在注册"
    @Published var registerstatu : Bool = false
    static let shared = Logincontroller()
    //    func getverifycode(account : String){
    //        MainService.promise(.getcode(phone: account)).done { (json) in
    //            print("\(json)")
    //        }.catch { (error) in
    //            print("获取验证码失败")
    //        }
    //    }
    /**手机号验证码登录
     */
    //    func loginUsingPhone(phone:String,code:String){
    //        // 手机号验证码登录
    //        YuntransLoginManager.login(phone: phone, verifycode: code).finally {
    //            //self.isloginsuccess = "登录成功"
    //            self.packagemanager.getuserpackages()
    //            print("login")
    //        }
    //    }
    func login(username: String, password: String){
        //账号密码登录
        LoginManager.login(username: username, password: password)
//        MainService.promise(.login(username: username, password: password)).done { [self] (json) in
//            self.loginmessage = json["message"].description
//            
//            print("\(json)")
//            if json["code"] == 200{
//                self.loginstatu = true
//                //TaskManager.shared.loadtasklist(json: json["data"])
//            }
//            else{
//                self.loginstatu = false
//            }
//        }.catch { (error) in
//            self.loginmessage = "登录失败"
//            self.loginstatu = false
//            //print("获取验证码失败")
//        }
    }
    /**账号注册*/
        func register(username: String, password: String){
            LoginManager.register(username: username, password: password)
        }
}
//class func login(username: String, password: String)-> PMKFinalizer{
//    return firstly { () -> Promise<JSON> in
//        return YuntransService.promise(.login(username: username, password: password))
//    }.done { (json) in
//        //print("登录：\(json)")
//        try loginConfig(json: json)
//
//    }.catch { (error) in
//         EWToast.showCenterWithText(text: "\(error.localizedDescription)")
//    }
//}

//import Foundation
//class  : ObservableObject{
//    @Published var loginmessage = "正在登录"
//    func login()
//}
