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

struct MarkingView: View {
    enum textlist: String, CaseIterable, Identifiable {
        case 源语言录音
        case 目标语言文本
        case 目标语言录音
        
        var id: String { self.rawValue }
    }
    enum speechlist: String, CaseIterable, Identifiable {
        case 源语言文本
        case 目标语言文本
        case 目标语言录音
        
        var id: String { self.rawValue }
    }
    @Binding var is_bilingual : Int
    @Binding var data_type : Int
    @State var viewState = CGSize.zero
    @Binding var ismarkingview : Bool
    @State var ReportSubject = ""
    @State var ReportContent = ""
    @State var SubjectHeight: CGFloat = screen.height/20
    @State var ContentHeight: CGFloat = screen.height/4
    @State var input = ""
    
    @State var texttargetinput = ""
    @State var speechtargetinput = ""
    @State var speechsourceinput = ""
    @ObservedObject var taskmanager = TaskManager.shared
    @State var speechsingleinput = ""
    @State var textlistchoice = textlist.源语言录音
    @State var speechlistchoice = speechlist.源语言文本
    @State var markalert = false
    //let markalert = UIAlertController(title:"haimeibiaozhu", message: nil, preferredStyle: .alert)
    //audio
    @State var isclickplayaudiobutton = false
    @State var textsourcespeechurl : URL?
    @State var texttargetspeechurl : URL?
    @State var speechtargetspeechurl : URL?
    @State var isRecord = false
    @State var titleText : String = ""
    @State var voiceTimer : Timer?
    @State var timeLabel = String(format: "%02d:%02d:%02d", 0, 0, 0)
    @State var duration : Int16 = 0//单位为1毫秒
    @State var stopTimer = false
    @State var url : URL?
    @ObservedObject var audioRecorder : AudioRecorder
    @ObservedObject var lm = LanguageManager.shared_
    @State var ishadrecord = false
    @State var isalert = false
    @State var isTestaudioView = true
    @State var singlespeechduration =  ""
    
    //audioplayer
    @ObservedObject var audioPlayer = AudioPlayer()
    @State var timeLine : CGFloat = 0
    @State var presentDuration : Int16 = 0
    @State var currentTime: TimeInterval = Date().timeIntervalSince1970
    @State var isPause = false//是否暂停过
    @State var actiontimes = 0
    @State var buttondisabled = false
    //@State var showSheet = false
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    HStack{
                        Button {
                            ismarkingview = false
                        } label: {
                            Image("返回箭头")
                                .resizable()
                                .frame(width: screen.width/10, height: screen.width/10)
                            //.padding([.top, .bottom])
                        }
                        Spacer()
                        Text("\(lm.markingviewdatamark)")
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
                    if (data_type == 0){
                        
                        VStack{
                            //双语标注
                            if is_bilingual == 0{
                                VStack{
                                    HStack {
                                        Text("\(lm.markingviewtextmarkdouble)")
                                            .font(.largeTitle)
                                            .padding(.vertical)
                                    }
                                    VStack{
                                        Text("\(taskmanager.tasksample?.data["text_content"].description ?? "正在加载")")
                                            .fixedSize(horizontal: false, vertical: true)
                                            .frame(width: screen.width-30)
                                            .padding(.top)
                                            .background(Color(red: 0.949, green: 0.949, blue: 0.949))
                                        Spacer().frame(height: screen.width/10)
                                        Picker(selection: $textlistchoice, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                                            Text("\(lm.markingviewsrecord)").tag(textlist.源语言录音)
                                            Text("\(lm.markingviewttext)").tag(textlist.目标语言文本)
                                            Text("\(lm.markingviewtrecord)").tag(textlist.目标语言录音)
                                        }
                                        .pickerStyle(.segmented)
                                        switch textlistchoice {
                                        case .源语言录音:
                                            VStack{
                                                if isRecord{
                                                    Text("\(timeLabel)")
                                                        .foregroundColor(.black)
                                                }
                                                else{
                                                    Text("\(lm.markingviewstartrecord)")
                                                        .foregroundColor(.black)
                                                }
                                                Button(action: {
                                                    if !self.isRecord{
                                                        //开始录音
                                                        stopTimer = false
                                                        self.textsourcespeechurl = self.startStreamRecord(who: "textsourcespeech")
                                                        print(textsourcespeechurl)
                                                    }
                                                    else{
                                                        //停止录音
                                                        self.finishStreamRecord()
                                                        //时间戳清零
                                                        timeLabel = String(format: "%02d:%02d:%02d", 0, 0, 0)
                                                        duration = 0
                                                        stopTimer = true
                                                        ishadrecord = true
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
                                            }
                                            .frame(width: screen.width-30, height: screen.width/2, alignment: .center)
                                            .foregroundColor(.white)
                                        case .目标语言文本:
                                            TextView(placeholder: "\(lm.markingviewinputtext)", text: self.$texttargetinput, minHeight: self.ContentHeight, calculatedHeight: self.$ContentHeight)
                                                .frame(minHeight: self.ContentHeight, maxHeight: self.ContentHeight)
                                                .background(Color(.white))
                                                .padding(.all)
                                        case .目标语言录音:
                                            VStack{
                                                if isRecord{
                                                    Text("\(timeLabel)")
                                                        .foregroundColor(.black)
                                                }
                                                else{
                                                    Text("\(lm.markingviewstartrecord)")
                                                        .foregroundColor(.black)
                                                }
                                                Button(action: {
                                                    if !self.isRecord{
                                                        //开始录音
                                                        stopTimer = false
                                                        self.texttargetspeechurl = self.startStreamRecord(who: "texttargetspeech")
                                                        print(texttargetspeechurl)
                                                    }
                                                    else{
                                                        //停止录音
                                                        self.finishStreamRecord()
                                                        //时间戳清零
                                                        timeLabel = String(format: "%02d:%02d:%02d", 0, 0, 0)
                                                        duration = 0
                                                        stopTimer = true
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
                                            }
                                            .frame(width: screen.width-30, height: screen.width/2, alignment: .center)
                                            .foregroundColor(.white)
                                        }
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
                                        taskmanager.taskskip(task_id: taskmanager.tasksample?.data["task_id"].description ?? "", sample_id: taskmanager.tasksample?.data["text_id"].description ?? "")
                                        textsourcespeechurl = URL(string: "0")
                                        texttargetspeechurl = URL(string: "0")
                                        //播放录音音频
                                        //self.audioPlayer.startPlayback(audio: self.url!, atTime: self.currentTime + Double(self.presentDuration)/100)
                                    } label: {
                                        Text("\(lm.markingviewskip)")
                                            .frame(maxWidth: screen.width/5)
                                            .foregroundColor(.black)
                                            .padding(.all)
                                    }
                                    .background(Color(red: 0.949, green: 0.949, blue: 0.949))
                                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                    .shadow(color: Color.gray, radius: 5, x: 0, y: 3)
                                    Spacer()
                                        .frame(width:screen.width/6)
                                    Button {
                                        //转码base64
                                        if ishadrecord{
                                            let source_audiodata = try? Data(contentsOf: self.textsourcespeechurl!)
                                            let target_audiodata = try? Data(contentsOf: self.texttargetspeechurl!)
                                            let source_audiostring = source_audiodata!.base64EncodedString()
                                            let target_audiostring = target_audiodata!.base64EncodedString()
                                            //print(encodedString)
                                            let contentstring = """
{
    "source_audio":"\(source_audiostring)",
    "target_text":"\(texttargetinput)",
    "target_audio": "\(target_audiostring)"}
"""
                                            
                                            //let contentjson = JSON.init(rawValue: contentstring)
                                            //print(contentjson)
                                            taskmanager.marktext(task_id: (taskmanager.tasksample?.data["task_id"].description) ?? "", texk_id: taskmanager.tasksample?.data["text_id"].description ?? "", content: contentstring,duration:singlespeechduration)
                                            ishadrecord = false
                                            url = URL(string: "0")
                                        }
                                    } label: {
                                        
                                        Text("\(lm.markingviewnext)")
                                            .frame(maxWidth: screen.width/5)
                                            .foregroundColor(.black)
                                            .padding(.all)
                                    }
                                    .background(Color(red: 0.949, green: 0.949, blue: 0.949))
                                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                    .shadow(color: Color.gray, radius: 5, x: 0, y: 3)
                                    
                                }
                                .padding([.leading, .trailing])
                                Spacer()
                            }
                            //单语标注
                            else{
                                VStack{
                                    HStack {
                                        Text("\(lm.markingviewtextmarksingle)")
                                            .font(.largeTitle)
                                            .padding(.vertical)
                                    }
                                    VStack{
                                        Text("\(taskmanager.tasksample?.data["text_content"].description ?? "\(lm.markingviewloading)")")
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
                                                Text("\(lm.markingviewstartrecord)")
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
                                                    //停止录音
                                                    print()
                                                    let startindex =  timeLabel.index(timeLabel.startIndex, offsetBy: 3)
                                                    let endindex =  timeLabel.index(timeLabel.startIndex, offsetBy: 5)
                                                    let startindexmiao =  timeLabel.index(timeLabel.startIndex, offsetBy: 6)
                                                    let endindexmiao =  timeLabel.index(timeLabel.startIndex, offsetBy: 8)
                                                    let newstring = String(timeLabel[startindex..<endindex])+"."+String(timeLabel[startindexmiao..<endindexmiao])
                                                    print(newstring)
                                                    self.finishStreamRecord()
                                                    singlespeechduration = newstring
                                                    //时间戳清零
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
                                        taskmanager.taskskip(task_id: taskmanager.tasksample?.data["task_id"].description ?? "", sample_id: taskmanager.tasksample?.data["text_id"].description ?? "")
                                        url = URL(string: "0")
                                        //播放录音音频
                                        //self.audioPlayer.startPlayback(audio: self.url!, atTime: self.currentTime + Double(self.presentDuration)/100)
                                    } label: {
                                        Text("\(lm.markingviewskip)")
                                            .frame(maxWidth: screen.width/5)
                                            .foregroundColor(.black)
                                            .padding(.all)
                                    }
                                    .background(Color(red: 0.949, green: 0.949, blue: 0.949))
                                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                    .shadow(color: Color.gray, radius: 5, x: 0, y: 3)
                                    Spacer()
                                        .frame(width:screen.width/6)
                                    Button(action:{
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
                                            taskmanager.marktext(task_id: (taskmanager.tasksample?.data["task_id"].description) ?? "", texk_id: taskmanager.tasksample?.data["text_id"].description ?? "", content: contentstring, duration: singlespeechduration)
                                            ishadrecord = false
                                            url = URL(string: "0")
                                        }
                                        //self.showSheet.toggle()
                                        
                                    },label:{
                                        Text("\(lm.markingviewnext)")
                                            .frame(maxWidth: screen.width/5)
                                            .foregroundColor(.black)
                                            .padding(.all)
                                    })
                                    .background(Color(red: 0.949, green: 0.949, blue: 0.949))
                                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                    .shadow(color: Color.gray, radius: 5, x: 0, y: 3)
                                    .alert(isPresented: $isalert, content: {
                                        Alert(title: Text("\(lm.markingviewerror)"), message: Text("\(lm.markingviewnorecord)"), dismissButton: .default(Text("\(lm.returnok)")))
                                    })
//                                    .sheet(isPresented: $showSheet){
//                                        Button(action: {
//                                            self.buttondisabled.toggle()
//                                        }, label: {
//                                            Text("请等待标注成功提示之后再继续")
//                                        })
//                                    }
                                }
                                .padding([.leading, .trailing])
                                .disabled(isRecord)
                                .disabled(buttondisabled)
                                Spacer()
                            }
                        }
                    }
                    
                    
                    //语音标注
                    else{
                        VStack{
                            VStack{
                                //双语标注
                                if is_bilingual == 0{
                                    HStack {
                                        Text("\(lm.markingviewvoicemarkdouble)")
                                            .font(.largeTitle)
                                            .padding(.vertical)
                                    }
                                    Picker(selection: $speechlistchoice, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                                        Text("\(lm.markingviewstext)").tag(speechlist.源语言文本)
                                        Text("\(lm.markingviewttext)").tag(speechlist.目标语言文本)
                                        Text("\(lm.markingviewtrecord)").tag(speechlist.目标语言录音)
                                    }
                                    .pickerStyle(.segmented)
                                    switch speechlistchoice{
                                    case .源语言文本:
                                        TextView(placeholder: "\(lm.markingviewinputtext)", text: self.$speechsourceinput, minHeight: self.ContentHeight, calculatedHeight: self.$ContentHeight)
                                            .frame(minHeight: self.ContentHeight, maxHeight: self.ContentHeight)
                                        
                                            .background(Color(.white))
                                            .padding(.all)
                                    case .目标语言文本:
                                        TextView(placeholder: "\(lm.markingviewinputtext)", text: self.$speechtargetinput, minHeight: self.ContentHeight, calculatedHeight: self.$ContentHeight)
                                            .frame(minHeight: self.ContentHeight, maxHeight: self.ContentHeight)
                                        
                                            .background(Color(.white))
                                            .padding(.all)
                                    case .目标语言录音:
                                        //录音控件
                                        VStack{
                                            if isRecord{
                                                Text("\(timeLabel)")
                                                    .foregroundColor(.black)
                                            }
                                            else{
                                                Text("\(lm.markingviewstartrecord)")
                                                    .foregroundColor(.black)
                                            }
                                            Button(action: {
                                                if !self.isRecord{
                                                    //开始录音
                                                    stopTimer = false
                                                    self.speechtargetspeechurl = self.startStreamRecord(who: "danyuurl")
                                                    print(speechtargetspeechurl)
                                                }
                                                else{
                                                    //停止录音
                                                    self.finishStreamRecord()
                                                    //时间戳清零
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
                                            
                                        }
                                        .frame(width: screen.width-30, height: screen.width/2, alignment: .center)
                                        .foregroundColor(.white)
                                    }
                                    HStack{
                                        Button {
                                            taskmanager.taskskip(task_id: taskmanager.tasksample?.data["task_id"].description ?? "", sample_id: taskmanager.tasksample?.data["text_id"].description ?? "")
                                            speechsourceinput = ""
                                            speechtargetinput = ""
                                        } label: {
                                            Text("\(lm.markingviewskip)")
                                                .frame(maxWidth: screen.width/5)
                                                .foregroundColor(.black)
                                                .padding(.all)
                                        }
                                        .background(Color(red: 0.949, green: 0.949, blue: 0.949))
                                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                        .shadow(color: Color.gray, radius: 5, x: 0, y: 3)
                                        Spacer()
                                            .frame(width:screen.width/6)
                                        Button {
                                            let speechtarget_audiodata = try? Data(contentsOf: self.speechtargetspeechurl!)
                                            let speechtarget_audiostring = speechtarget_audiodata!.base64EncodedString()
                                            //print(encodedString)
                                            let contentstring = """
{
    "source_text": "\($speechsourceinput)",
    "target_text": "\($speechtargetinput)",
    "target_audio": "\(speechtarget_audiostring)"
}
"""
                                            
                                            //let contentjson = JSON.init(rawValue: contentstring)
                                            //print(contentjson)
                                            taskmanager.markspeech(task_id: (taskmanager.tasksample?.data["task_id"].description) ?? "", audio_id: taskmanager.tasksample?.data["audio_id"].description ?? "", content: contentstring,type: 0)
                                            ishadrecord = false
                                            speechtargetspeechurl = URL(string: "0")
                                        } label: {
                                            Text("\(lm.markingviewnext)")
                                                .frame(maxWidth: screen.width/5)
                                                .foregroundColor(.black)
                                                .padding(.all)
                                        }
                                        .background(Color(red: 0.949, green: 0.949, blue: 0.949))
                                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                        .shadow(color: Color.gray, radius: 5, x: 0, y: 3)
                                        
                                    }
                                    .padding([.leading, .bottom, .trailing])
                                    Spacer()
                                }
                                //单语标注
                                else{
                                    Spacer()
                                    VStack{
                                        HStack {
                                            Text("\(lm.markingviewtextmarksingle)")
                                                .font(.largeTitle)
                                                .padding(.vertical)
                                        }
                                        //播放器
                                        HStack{
                                            //播放按钮
                                            Button(action: {
                                                if actiontimes == 0{
                                                    speechsingleinput = taskmanager.tasksample?.data["model_text"].description ?? ""}
                                                self.audioPlayer.startPlayback(audio: audiopath!, atTime: self.currentTime + Double(self.presentDuration)/100)
                                                isclickplayaudiobutton = true
                                                actiontimes = 1
                                            }) {
                                                Image(systemName: audioPlayer.isPlaying ? "pause.circle" : "arrowtriangle.right.circle")
                                                    .resizable()
                                                    .foregroundColor(.blue)
                                                    .frame(width: screen.width/7, height: screen.width/7)
                                            }
                                            .padding(.leading)
                                            //进度条
                                            //Text("\(showOnClock(cnt: self.presentDuration))/\(showOnClock(cnt: self.voiceData.duration))")
                                            ZStack(alignment: .leading) {
                                                Rectangle()
                                                    .cornerRadius(2)
                                                    .foregroundColor(.gray)
                                                    .frame(height: 5.0)
                                                    .padding(20)
                                                Rectangle()
                                                    .cornerRadius(2)
                                                    .foregroundColor(.orange)
                                                    .frame(width: timeLine, height: 5.0)
                                                    .padding(20)
                                            }
                                        }
                                        //"model_text"
//                                        TextView(placeholder: "请输入该音频对应的文本", text: self.$speechsingleinput, minHeight: self.ContentHeight, calculatedHeight: self.$ContentHeight)
                                        TextView(placeholder: "\(lm.markingviewinputtext)", text: self.$speechsingleinput, minHeight: self.ContentHeight, calculatedHeight: self.$ContentHeight)
                                            .frame(minHeight: self.ContentHeight, maxHeight: self.ContentHeight)
                                        
                                            .background(Color(.white))
                                            .padding(.all)
                                        //.frame(width: screen.width-30, height: screen.width-10, alignment: .center)
                                        HStack{
                                            Button {
                                                taskmanager.taskskip(task_id: taskmanager.tasksample?.data["task_id"].description ?? "", sample_id: taskmanager.tasksample?.data["audio_id"].description ?? "")
                                                speechsingleinput = ""
                                            } label: {
                                                Text("\(lm.markingviewskip)")
                                                    .frame(maxWidth: screen.width/5)
                                                    .foregroundColor(.black)
                                                    .padding(.all)
                                            }
                                            .background(Color(red: 0.949, green: 0.949, blue: 0.949))
                                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                            .shadow(color: Color.gray, radius: 5, x: 0, y: 3)
                                            Spacer()
                                                .frame(width:screen.width/6)
                                            Button {
                                                self.buttondisabled.toggle()
                                                markalert = false
                                                if speechsingleinput != "" && isclickplayaudiobutton {
                                                    let contentstring = speechsingleinput
                                                    taskmanager.markspeech(task_id: (taskmanager.tasksample?.data["task_id"].description) ?? "", audio_id: taskmanager.tasksample?.data["audio_id"].description ?? "", content: contentstring, type: is_bilingual)
                                                    speechsingleinput = ""
                                                }
                                                else{
                                                    markalert = true
                                                }
                                                EWToast.showCenterWithText(text: "请等待标注成功提示之后再继续")
                                                self.buttondisabled.toggle()
                                            } label: {
                                                Text("\(lm.markingviewnext)")
                                                    .frame(maxWidth: screen.width/5)
                                                    .foregroundColor(.black)
                                                    .padding(.all)
                                            }
                                            .background(Color(red: 0.949, green: 0.949, blue: 0.949))
                                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                            .shadow(color: Color.gray, radius: 5, x: 0, y: 3)
                                            .alert(isPresented: $markalert, content: {
                                                Alert(title: Text("\(lm.markingviewerror)"), message: Text("\(lm.markingviewnomark)"), dismissButton: .default(Text("\(lm.returnok)")))
                                            })
                                            
//                                            .sheet(isPresented: $showSheet){
//                                                Button(action: {
//                                                    self.buttondisabled.toggle()
//                                                }, label: {
//                                                    Text("请等待标注成功提示之后再继续")
//                                                })
//                                            }

                                        }
                                        .padding([.leading, .bottom, .trailing])
                                        .disabled(buttondisabled)
                                        Spacer()
                                    }
                                    .onTapGesture(perform: hideKeyboard)
                                }
                            }
                        }
                    }
                }
            }
            if data_type == 0{
                TestaudioView(ismarkingview: $ismarkingview, isTestaudioView: $isTestaudioView, audioRecorder: AudioRecorder())
                    .offset(y:isTestaudioView ? screen.height/25 : screen.height)
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
    
    func finishStreamRecord(){
        //计时结束
        self.stopTimer = true
        //音频结束
        audioRecorder.stopRecording()
    }
}
let todayTime = Date().toString(dateFormat: "YY-MM-dd HH:mm:ss")

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}

struct TextView: UIViewRepresentable {
    var placeholder: String
    @Binding var text: String
    
    var minHeight: CGFloat
    @Binding var calculatedHeight: CGFloat
    
    init(placeholder: String, text: Binding<String>, minHeight: CGFloat, calculatedHeight: Binding<CGFloat>) {
        self.placeholder = placeholder
        self._text = text
        self.minHeight = minHeight
        self._calculatedHeight = calculatedHeight
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        
        // Decrease priority of content resistance, so content would not push external layout set in SwiftUI
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = UIColor(white: 0.0, alpha: 0.05)
        
        textView.text = text
        
        // Set the placeholder
//        textView.text = placeholder
//        textView.textColor = UIColor.lightGray
        
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
        textView.text = self.text
        
        recalculateHeight(view: textView)
    }
    
    func recalculateHeight(view: UIView) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if minHeight < newSize.height && $calculatedHeight.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                self.$calculatedHeight.wrappedValue = newSize.height // !! must be called asynchronously
            }
        } else if minHeight >= newSize.height && $calculatedHeight.wrappedValue != minHeight {
            DispatchQueue.main.async {
                self.$calculatedHeight.wrappedValue = self.minHeight // !! must be called asynchronously
            }
        }
    }
    
    class Coordinator : NSObject, UITextViewDelegate {
        
        var parent: TextView
        
        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }
        
        func textViewDidChange(_ textView: UITextView) {
            // This is needed for multistage text input (eg. Chinese, Japanese)
            if textView.markedTextRange == nil {
                parent.text = textView.text ?? String()
                parent.recalculateHeight(view: textView)
            }
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = parent.placeholder
                textView.textColor = UIColor.lightGray
            }
        }
    }
}
//以时钟格式显示时长
func showOnClock(cnt:Int16) -> String{
    return String(format: "%02d:%02d:%02d", cnt/6000, (cnt/100)%60, cnt%100)
}
//struct MarkingView_Previews: PreviewProvider {
//    static var previews: some View {
//        MarkingView()
//    }
//}

