//
//  TaskManager.swift
//  SpeechMarking
//
//  Created by Crabbit on 2022/6/20.
//

import Foundation
import SwiftyJSON
import AVFAudio
import PromiseKit

class TaskManager:ObservableObject{
    struct TaskData : Hashable,Codable{
        var task_id : String
        var group_num : String
        var target_language_code : String
        var task_name : String
        var source_language_code : String
        var data_type : Int
        var is_bilingual : Int
        var deadline : String
        var task_status : Int
    }
    
    
    static var shared = TaskManager()
    @Published var tasklist : Array = []
    @Published var taskdata : TaskManager.TaskData?
    @Published var taskdatas : [TaskManager.TaskData] = []
    @Published var tasksample : MainResp.sampleResp?
    @Published var testsample : MainResp.testsampleResp?
    @Published var teststatu = false
    
    @Published var getsamplestatu = false
    
    
    //@Published var tasklist : JSON?
    func loadtasklist(json: JSON){
        tasklist = json["userinfo"]["join_task_group"].description.split(separator: ";")
        let decoder = JSONDecoder()
        
        for a in tasklist{
            //print(a)
            var b = json["groupinfo"]["\(a)"]
            //print(b)
            taskdata = try? JSONDecoder().decode(TaskData.self, from: "\(b)".data(using: .utf8)!)
            if taskdata != nil{
                taskdatas.append(taskdata!)
            }
        }
        //print(taskdatas)
    }
    
    func getsample(token: String, id :String){
        
        //        MainService.promise(.getsample(token: token, task_id: id)).done { json in
        //            print("getsample")
        //            print(json)
        //        }
        MainService.promise(.getsample(token: token, task_id: id)).done { [self] json in
            print("getsample")
            print(json)
            if json["code"] == 200{
                getsamplestatu = true
                tasksample = try? JSONDecoder().decode(MainResp.sampleResp.self, from: "\(json)".data(using: .utf8)!)
                //print(tasksample?.data["text_content"])
                //print(tasksample?.data["audio_route"])
                guard let data = Data(base64Encoded: (tasksample?.data["audio_route"].description) ?? "null",options: .ignoreUnknownCharacters)else{
                    return
                }
                let documentPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
                let audioFilename = documentPath.appendingPathComponent("fromhouduan")//有没有.m4a好像都无所谓？
                audiopath = audioFilename
                try? data.write(to: audiopath!)
            }
            else{
                EWToast.showCenterWithText(text: json["message"].description)
            }
        }
    }
    func gettestsample(token: String, id :String){
        
        let intid = Int(id)
        //        MainService.promise(.getsample(token: token, task_id: id)).done { json in
        //            print("getsample")
        //            print(json)
        //        }
        MainService.promise(.gettestsample(task_id: intid!)).done { [self] json in
            print("gettestsample")
            print(json)
            if json["code"] == 200{
                testsample = try? JSONDecoder().decode(MainResp.testsampleResp.self, from: "\(json)".data(using: .utf8)!)
            }
            else{
                EWToast.showCenterWithText(text: json["message"].description)
            }
        }
    }
    
    func testmark(task_id: String, content: String){
        let task_idint = Int(task_id)!
        let reqtest = """
                {
                    "task_id": \(task_idint),
                    "sentence_content": "\(content)"
                }
                """
        let con = JSON.init(rawValue: reqtest)
        print(con)
        MainService.promise(.testuser(task_id: task_idint, audio_content: con!)).done { json in
            print(json)
            if json["message"] == "成功"{
                print("biaozhuchenggong")
                self.teststatu = true
                EWToast.showCenterWithText(text: "测试成功,请点击'好的'开始标注",duration: 3.0)
            }
            else{
                print(json["message"])
                EWToast.showCenterWithText(text: json["message"].description)
            }
            
        }.catch { (error) in
            print(error)
        }
    }
    
    func marktext(task_id: String, texk_id: String, content: String, duration: String){
        let task_idint = Int(task_id)!
        let text_id = Int(texk_id)!
        let durationint =  Float(duration)!
        //old request
        //        let reqtest = """
        //{
        //    "task_id": \(task_idint),
        //    "text_id": \(text_id),
        //    "content": {
        //        "target_audio": "\(content)"
        //    }
        //}
        //"""
        
        //new request
        let reqtest = """
        {
            "task_id": \(task_idint),
            "text_id": \(text_id),
            "duration": \(durationint),
            "content": \(content)
        }
        """
        let con = JSON.init(rawValue: reqtest)
        print(con)
        MainService.promise(.labeltext(task_id: task_idint, texk_id: text_id, content: con!)).done { json in
            print(json)
            if json["code"] == 200{
                print("biaozhuchenggong")
                self.getsample(token: LoginManager.userInfo!.token, id: task_id)
                EWToast.showCenterWithText(text: "标注成功")
            }
            else{
                print(json["message"])
                EWToast.showCenterWithText(text: json["message"].description)
                
            }
            
        }.catch { (error) in
            print(error)
        }
    }
    func taskskip(task_id: String, sample_id: String){
        let task_idint = Int(task_id)!
        let sample_idint = Int(sample_id)!
        print(task_idint)
        print(sample_idint)
        do {MainService.promise(.skip(task_id: task_idint, sample_id: sample_idint)).done {json in
            print(json)
            if json["code"] == 200{
                print("跳过")
                self.getsample(token: LoginManager.userInfo!.token, id: task_id)
                EWToast.showCenterWithText(text: "已跳过")
            }
        }}
        catch let error {
            print(error.localizedDescription)
        }
    }
    func markspeech(task_id: String, audio_id: String, content: String, type: Int){
        let task_idint = Int(task_id)!
        let audio_idint = Int(audio_id)!
        //new request
        var reqtest = ""
        if type == 0{
            reqtest = """
                    {
                        "task_id": \(task_idint),
                        "audio_id": \(audio_idint),
                        "content": \(content)
                    }
                    """
        }
        else{
            reqtest = """
                    {
                        "task_id": \(task_idint),
                        "audio_id": \(audio_idint),
                        "content": "\(content)"
                    }
                    """
        }
        
        let con = JSON.init(rawValue: reqtest)
        print(con)
        MainService.promise(.labelaudio(task_id: task_idint, audio_id: audio_idint, content: con!)).done { json in
            print(json)
            if json["code"] == 200{
                print("biaozhuchenggong")
                self.getsample(token: LoginManager.userInfo!.token, id: task_id)
                EWToast.showCenterWithText(text: "标注成功")
            }
            else{
                print(json["message"])
                EWToast.showCenterWithText(text: json["message"].description)
            }
            
        }.catch { (error) in
            print(error)
        }
    }
}



var audiopath : URL?
