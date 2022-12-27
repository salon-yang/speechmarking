//
//  MarkingView.swift
//  SpeechMarking
//
//  Created by Crabbit on 2022/6/23.
//

import SwiftUI
import AVKit
import AVFoundation
import SwiftyJSON
import SocketIO

struct TestaudioView: View {

    @Binding var ismarkingview : Bool
    @State var viewState = CGSize.zero
    @Binding var isTestaudioView : Bool
    @State var ReportSubject = ""
    @State var ReportContent = ""
    @State var SubjectHeight: CGFloat = screen.height/20
    @State var ContentHeight: CGFloat = screen.height/4
    @State var input = ""
    @ObservedObject var taskmanager = TaskManager.shared
    @State var markalert = false
    //let markalert = UIAlertController(title:"haimeibiaozhu", message: nil, preferredStyle: .alert)
    //audio
    @State var isRecord = false
    @State var titleText : String = ""
    @State var voiceTimer : Timer?
    @State var timeLabel = String(format: "%02d:%02d:%02d", 0, 0, 0)
    @State var duration : Int16 = 0//单位为1毫秒
    @State var stopTimer = false
    @State var url : URL?
    @ObservedObject var audioRecorder : AudioRecorder
    @State var ishadrecord = false
    @State var isalert = false
    @State var isclicktestbutton = false
    
    
    //audioplayer
    @ObservedObject var audioPlayer = AudioPlayer()
    @State var timeLine : CGFloat = 0
    @State var presentDuration : Int16 = 0
    @State var currentTime: TimeInterval = Date().timeIntervalSince1970
    @State var isPause = false//是否暂停过
    
    func testfinish(){
        if taskmanager.teststatu{
            isTestaudioView = false
        }
        
    }
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    HStack{
                        Button {
                            isTestaudioView = false
                            ismarkingview = false
                        } label: {
                            Image("返回箭头")
                                .resizable()
                                .frame(width: screen.width/10, height: screen.width/10)
                            //.padding([.top, .bottom])
                        }
                        Spacer()
                        Text("标注测试")
                        //.font(.title)
                            .foregroundColor(Color.black)
                            .padding([.trailing], screen.width/10)
                        Spacer()

                    }
                    .padding(.top, screen.width/10)
                    .frame(width: screen.width)
                    .background(Color(red: 0.949, green: 0.949, blue: 0.949))
                    Spacer().frame(height:screen.width/5)
                    //文本标注
                    VStack{
                        //单语标注
                            VStack{
                                VStack{
                                    Text("\(taskmanager.testsample?.message.description ?? "正在加载")")
                                    //Text("正在加载")
                                        .fixedSize(horizontal: false, vertical: true)
                                        .frame(width: screen.width-30)
                                        .padding(.top)
                                        .background(Color(red: 0.949, green: 0.949, blue: 0.949))
                                    Spacer().frame(height:0)
                                    //录音控件
                                    VStack{
                                        if isRecord{
                                            Text("\(timeLabel)")
                                                .foregroundColor(.black)
                                        }
                                        else{
                                            Text("请点击按钮开始录音")
                                                .foregroundColor(.black)
                                        }
                                        Button(action: {
                                            if !self.isRecord{
                                                //开始录音
                                                stopTimer = false
                                                self.url = self.startStreamRecord(who: "danyuurl")
                                                print(url)
                                            }
                                            else{
//                                                //暂停录音
//                                                self.pauseRecord()
                                                //停止录音
                                                self.finishStreamRecord()
                                                //时间戳清零
//                                                print()
//                                                let startindex =  timeLabel.index(timeLabel.startIndex, offsetBy: 3)
//                                                let endindex =  timeLabel.index(timeLabel.startIndex, offsetBy: 5)
//                                                let startindexmiao =  timeLabel.index(timeLabel.startIndex, offsetBy: 6)
//                                                let endindexmiao =  timeLabel.index(timeLabel.startIndex, offsetBy: 8)
//                                                let newstring = String(timeLabel[startindex..<endindex])+"."+String(timeLabel[startindexmiao..<endindexmiao])
//                                                print(newstring)
                                                timeLabel = String(format: "%02d:%02d:%02d", 0, 0, 0)
                                                duration = 0
                                                stopTimer = true
                                                ishadrecord = true
                                                isalert = false
                                            }
                                            self.isRecord.toggle()
                                        }) {
                                            VStack{
                                                Image(systemName: self.isRecord ? "stop.circle" : "circle")
                                                    .resizable()
                                                    .imageScale(.large)
                                                    .frame(width: screen.width/6, height: screen.width/6)
                                                    .background(isRecord ? Color.black : Color.red)
                                                    .cornerRadius(40)
                                            }
                                            
                                            //.padding([.top, .leading, .trailing])
                                        }
//                                        Button(action:{
//                                            ishadrecord = true
//                                                                                            //停止录音
//                                                                                            self.finishStreamRecord()
//                                                                                            //时间戳清零
//                                                                                            timeLabel = String(format: "%02d:%02d:%02d", 0, 0, 0)
//                                                                                            duration = 0
//                                                                                            stopTimer = true
//                                                                                            ishadrecord = true
//                                                                                            isalert = false
//                                        }) {
//                                            VStack{
//                                                Image(systemName: self.isRecord ? "stop.circle" : "circle")
//                                                    .resizable()
//                                                    .imageScale(.large)
//                                                    .frame(width: screen.width/6, height: screen.width/6)
//                                                    .background(isRecord ? Color.black : Color.red)
//                                                    .cornerRadius(40)
//                                            }
//                                        }
                                        HStack{
                                            Spacer()
                                            if ishadrecord{
                                                Button {
                                                    //播放录音音频
                                                    self.audioPlayer.startPlayback(audio: self.url!, atTime: self.currentTime + Double(self.presentDuration)/100)
                                                } label: {
                                                    Image(systemName: "arrowtriangle.right.circle")
                                                        .resizable()
                                                        .foregroundColor(.blue)
                                                        .frame(width: screen.width/7, height: screen.width/7)
                                                }
                                            }
                                        }
                                        
                                    }
                                    .frame(width: screen.width-30, height: screen.width/2, alignment: .center)
                                    .background(Color.white)
                                    .foregroundColor(.white)
                                    Spacer()
                                        .frame(height: 5)
                                        .background(Color(red: 0.949, green: 0.949, blue: 0.949))
                                }
                                .frame(width: screen.width-20)
                                
                                //.frame(width: screen.width-20, height: screen.width+10, alignment: .center)
                                .background(Color(red: 0.949, green: 0.949, blue: 0.949))
                                .padding(.horizontal)
                                
                            }
                            
                            Spacer()
                                .frame(height: screen.width/10)
                            HStack{
                                Button {
                                    
                                    if !ishadrecord {
                                        isalert = true
                                    }
                                    //转码base64
                                    if ishadrecord{
                                        let audioData = try? Data(contentsOf: self.url!)
                                        let encodedString = audioData!.base64EncodedString()
                                        //print(encodedString)
                                        let contentstring = """
{"target_audio": "\(encodedString)"}
"""
                                        
                                        let contentjson = JSON.init(rawValue: contentstring)
                                        //print(contentjson)
                                        taskmanager.testmark(task_id: (taskmanager.tasksample?.data["task_id"].description) ?? "", content: encodedString)
                                        ishadrecord = false
                                        url = URL(string: "0")
                                        isclicktestbutton = true
                                    }
                                } label: {
                                    Text("测试")
                                        .frame(maxWidth: screen.width/5)
                                        .foregroundColor(.black)
                                        .padding(.all)
                                }
                                .background(Color(red: 0.949, green: 0.949, blue: 0.949))
                                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                .shadow(color: Color.gray, radius: 5, x: 0, y: 3)
                                .alert(isPresented: $isalert, content: {
                                    Alert(title: Text("测试错误"), message: Text("该数据未录音"), dismissButton: .default(Text("好的")))
                                })
                                .alert(isPresented: $isclicktestbutton, content: {
                                    Alert(title: Text("测试数据已发送"), message: Text("请等待测试结果"), dismissButton: .default(Text("好的"),action: testfinish))
                                })
                            }
                            .padding([.leading, .trailing])
                            .disabled(isRecord)
                            Spacer()
                    }
                }
            }
        }
        .background(Color.white)
        .frame(width: screen.width, height: screen.height)
    }
    //play base64
    func playbase64(){
        var audioPlayer: AVAudioPlayer!
        guard let data = Data(base64Encoded: (taskmanager.tasksample?.data["audio_route"].description)!,options: .ignoreUnknownCharacters)else{
            return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            audioPlayer = try AVAudioPlayer(data: data, fileTypeHint: AVFileType.mp3.rawValue)
            //audioPlayer = try AVAudioPlayer(contentsOf: audio, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let audioPlayer = audioPlayer else { return }
            
            audioPlayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    //voice func
    func beginTimer(){
        self.voiceTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true)
        {(timer) in
            self.duration += 1
            self.timeLabel = String(format: "%02d:%02d:%02d", self.duration/6000, (self.duration/100)%60, self.duration%100)
            if self.stopTimer {
                timer.invalidate()
            }
        }
    }
    
    
    func startStreamRecord(who:String) -> URL{
        //计时开始
        self.beginTimer()
        //保存音频
        let voiceURL = audioRecorder.startRecording(who: who)
        //print(voiceURL)
        return voiceURL
    }
    func getSize(url: URL)->UInt64
    {
        var fileSize : UInt64 = 0
        
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: url.path)
            fileSize = attr[FileAttributeKey.size] as! UInt64
            
            let dict = attr as NSDictionary
            fileSize = dict.fileSize()
        } catch {
            print("Error: \(error)")
        }
        
        return fileSize
    }
    func pauseRecord(){
        audioRecorder.audioRecorder.pause()
    }
    
    func finishStreamRecord(){
        //计时结束
        self.stopTimer = true
        //音频结束
        audioRecorder.stopRecording()
    }
}
