//
//  MainAPI.swift
//  SpeechMarking
//
//  Created by Crabbit on 2022/6/10.
//

import Alamofire
import Foundation
import SwiftyJSON
import Moya
import PromiseKit
import RxSwift
import SocketIO

var netname = netlist.Other
var yuntrans_base_url = "http://yuntrans.vip"
var marking_base_url = "https://speech.xiaoyuzhineng.com:20081/server/"

//if netname == netlist.China{
//    //真实环境（园区）
//    //return URL(string:"https://speech.xiaoyuzhineng.com:20081/server/")!
//    marking_base_url = "https://speech.xiaoyuzhineng.com:20081/server/"
//}
//else{
//    //真实环境（境外）
//    marking_base_url = "http://8.219.111.132:20081/server/"
//}

enum MainResp{
    struct loginResp:Decodable{
        var code : Int
        var message: String
        var token : String
        var data: JSON
    }
    struct sampleResp:Decodable{
        var code : Int
        var message: String
        var data: JSON
    }
    struct testsampleResp:Decodable{
        var code : Int
        var process_time: String
        var message: String
    }
    struct query_apkcode_APPLEResp:Codable{
        let apk_url : String
        let description : String
        let return_code : String
        let version_code : String
    }
}

enum MainService{
    // --------------用户登录接口-------------
    case login(username: String, password: String)
    // ---------------END-----------------
    // --------------用户获取样本接口-------------
    case getsample(token: String, task_id: String)
    // ---------------END-----------------
    // --------------用户标注文本样本接口-------------
    case labeltext(task_id: Int, texk_id: Int, content: JSON)
    //case labeltext(task_id: String, texk_id: String, target_audio: String, source_audio: String, target_text: String)
    // ---------------END-----------------
    // --------------用户标注语音样本接口-------------
    case labelaudio(task_id: Int, audio_id: Int, content: JSON)
    // ---------------END-----------------
    // --------------获取该任务中总任务与剩余任务接口-------------
    case gettasknumber(token: String, task_id: String)
    // ---------------END-----------------
    // --------------获取该任务中总任务与剩余任务接口-------------
    case skip(task_id: Int, sample_id: Int)
    // ---------------END-----------------
    
    case gettestsample(task_id: Int)
    
    case testuser(task_id: Int, audio_content: JSON)
    
    // 获取版本号和更新提示
    case query_apkcode_APPLE
    
    case register(username: String, password: String)
    
    case deleteuser
}


extension MainService:TargetType{
    

    //测试环境（校内）
    //var marking_base_url = "http://222.197.219.26:52517/"
    //return URL(string:"http://222.197.219.26:52517/")!
    
    ////临时环境
    //var marking_base_url = "http://8.219.111.132:20081/tmp_server/"
    
    var baseURL : URL {
        //任意值，不影响请求地址
        return URL(string:"https://speech.xiaoyuzhineng.com:20081/server/")!
    }
    var path:String{
        switch self {
        case .login(let username, let password):
            return marking_base_url + "login"
        case .getsample(let token, let task_id):
            return marking_base_url + "getsample"
        case .labeltext(let task_id, let texk_id, let content):
        //case .labeltext(let task_id, let texk_id, let target_audio, let source_audio, let target_text):
            return marking_base_url + "labeltext"
        case .labelaudio(let task_id, let audio_id, let content):
            return marking_base_url + "labelaudio"
        case .gettasknumber(let token, let task_id):
            return marking_base_url + "gettasknumber"
        case .skip(let task_id, let sample_id):
            return marking_base_url + "jumpsample"
        case .gettestsample(let task_id):
            return marking_base_url + "suexasen"
        case .testuser(let token, let audio_content):
            return marking_base_url + "usertestwer"
        case .query_apkcode_APPLE:
            return yuntrans_base_url + "/api/query/apkcode/IOSSPEECHTAGGING"
        case .register(let username, let password):
            return marking_base_url + "register"
        case .deleteuser:
            return marking_base_url + "delIosUser"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login(let username, let password):
            return .post
        case .getsample(let token, let task_id):
            return .post
        case .labeltext(let task_id, let texk_id, let content):
            return .post
        case .labelaudio(let task_id, let audio_id, let content):
            return .post
        case .gettasknumber(let token, let task_id):
            return .post
        case .skip(let task_id, let sample_id):
            return .post
        case .gettestsample(let task_id):
            return .post
        case .testuser(let token, let audio_content):
            return .post
        case .query_apkcode_APPLE:
            return .get
        case .register(let username, let password):
            return .post
        case .deleteuser:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8) ?? Data()
    }
    
    var task: Task {
        switch self {
        case .login(let username, let password):
            return .requestParameters(parameters: ["username" : username, "password" : password,"device_info" : "iOS" + VersionController.iosVersion], encoding: JSONEncoding.default)
        case .getsample(let token, let task_id):
            return .requestParameters(parameters: ["task_id" : task_id], encoding: JSONEncoding.default)
            //return .requestParameters(parameters: ["task_id" : task_id, "token" : token], encoding: JSONEncoding.default)
        case .labeltext(let task_id, let texk_id, let content):
            return .requestJSONEncodable(content)
            //return .requestParameters(parameters: ["task_id" : task_id, "text_id" : texk_id, "content" :content], encoding: JSONEncoding.default)
        case .labelaudio(let task_id, let audio_id, let content):
            return .requestJSONEncodable(content)
        case .gettasknumber(let token, let task_id):
            return .requestPlain
        case .skip(let task_id, let sample_id):
            return .requestParameters(parameters: ["task_id" : task_id, "sample_id" : sample_id], encoding: JSONEncoding.default)
        case .gettestsample(let task_id):
            return .requestParameters(parameters: ["task_id" : task_id], encoding: JSONEncoding.default)
        case .testuser(let token, let audio_content):
            return .requestJSONEncodable(audio_content)
        case .query_apkcode_APPLE:
            return .requestPlain
        case .register(let username, let password):
            return .requestParameters(parameters: ["username" : username, "password" : password, "language_type":"英文", "device_info" : "iOS" + VersionController.iosVersion], encoding: JSONEncoding.default)
        case .deleteuser:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var httpHeaders: [String: String] = [:]
        httpHeaders["token"] = LoginManager.userInfo?.token
        return httpHeaders
    }
}

struct MainError:Error,LocalizedError{
    private var desc:String = "服务器发生错误"
    
    init(){}
    
    init(description:String){
        self.desc = description
    }
    public var errorDescription: String?{
        return self.desc
    }
    
    public var localizedDescription: String{
        return self.desc
    }
}

extension MainService{
    
    static var manager:Alamofire.SessionManager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 30 // timeout
        let manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }
    
    static let provider = MoyaProvider<MainService>(manager:manager).rx
    static let noLoginProvider = MoyaProvider<MainService>().rx
    
    static func noLoginPromise(_ target: MainService) -> Promise<JSON> {
        return MainService.promise(target, provider: MainService.noLoginProvider)
    }
    
    static func promise(_ target: MainService) -> Promise<JSON> {
        return MainService.promise(target, provider: MainService.provider)
    }
    
    static func promise(_ target: MainService, provider _provider: Reactive<MoyaProvider<MainService>>) -> Promise<JSON> {
        return
        firstly{
            Promise<JSON> { seal in
                provider.base.request(target, completion: { (result) in
                    switch result {
                    case let .success(moyaResponse):
                        
                        guard moyaResponse.statusCode == 200 else {
                            seal.reject(NSError(domain: "\(moyaResponse.statusCode)", code: moyaResponse.statusCode, userInfo: ["response_message": "Response message from server"]))
                            return
                        }
                        
                        if let json = try? JSON(data: moyaResponse.data){
                            if json.dictionaryObject?["return_code"] as? String == "ERROR"{
                                if let return_msg = json.dictionaryObject?["return_msg"] as? String{
                                    if return_msg.hasPrefix("PARAM"){
                                        seal.reject(MainError(description: "接口异常，请检查更新！！"))
                                    }else{
                                        seal.reject(MainError(description: return_msg))
                                    }
                                }else{
                                    seal.reject(MainError())
                                }
                            }else{
                                seal.fulfill(json)
                            }
                        }else{
                            print("json 错误\n数据大小：\(moyaResponse.data.count),\n 数据：\(String(data:moyaResponse.data, encoding:.ascii))\n\(target.baseURL.absoluteString + target.path)")
                            seal.reject(SwiftyJSONError.invalidJSON as Error)
                        }
                    case let .failure(error):
                        seal.reject(error)
                    }
                })
            }
        }
    }
    // 保存cookie
    static func saveCookies() {
        if let cookies = provider.base.manager.session.configuration.httpCookieStorage?.cookies{
            ArchiveUtil.archiveObject(object: cookies, forKey: "vip.yuntrans.cookieSave")
        }
    }
    
    // 加载cookie
    static func loadSavedCookies() {
        if let cookies = ArchiveUtil.readObjectFromArchive(forKey: "vip.yuntrans.cookieSave") as? [HTTPCookie] {
            for cookie in cookies {
            provider.base.manager.session.configuration.httpCookieStorage?.setCookie(cookie)
            }

        }
    }
    
    static func clearCookies(){
        provider.base.manager.session.configuration.httpCookieStorage = HTTPCookieStorage()
    }
    
    static func showCookies(){
        if let cookies = provider.base.manager.session.configuration.httpCookieStorage?.cookies{
            for cookie in cookies{
                print(cookie)
            }
        }
    }
    
    
    static let session = Alamofire.SessionManager.default

    /**
     通用方法：适用于请求体是JSON的POST请求
     - Parameter endPoint: 请求链接
     - Parameter jsonString: 请求参数
     */
    static func requestWithJSONString(endPoint:String, jsonString:String)->DataRequest{
        let urlEndPoint = URL(string: endPoint)!
        var request = URLRequest(url:urlEndPoint)
        
        // 传输json string 的必要操作
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonString.data(using: .utf8)
        request.httpMethod = HTTPMethod.post.rawValue
        
        return session.request(request)
    }
    
    static func requestWithGetMethod(endPoint:String)->DataRequest{
        let urlEndPoint = URL(string: endPoint)!
        var request = URLRequest(url:urlEndPoint)
        request.httpMethod = HTTPMethod.get.rawValue
        return session.request(request)
    }
}

class MainManager {
    var promise : Promise<JSON>?
    
    var text : String?
    
    //var MainRet : MainResp.MainResp?
    
    static var _shared : MainManager? = MainManager()
    
    static var shared : MainManager{
        get{
            if MainManager._shared != nil{
                return MainManager._shared!
            }else{
                MainManager._shared = MainManager()
                return MainManager._shared!
            }
        }
    }
    private init(){
        
    }
    func updateurl(){
        marking_base_url = (netname == netlist.China) ?  "https://speech.xiaoyuzhineng.com:20081/server/":"http://8.219.111.132:20081/server/"
    }
}
