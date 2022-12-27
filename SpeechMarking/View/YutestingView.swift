////
////  YutestingView.swift
////  SpeechMarking
////
////  Created by Crabbit on 2022/7/27.
////
//
//import SwiftUI
//
//struct YutestingView: View {
//    //audio
//    @State var testspeechurl : URL?
//    @State var isRecord = false
//    @State var titleText : String = ""
//    @State var voiceTimer : Timer?
//    @State var timeLabel = String(format: "%02d:%02d:%02d", 0, 0, 0)
//    @State var duration : Int16 = 0//单位为1毫秒
//    @State var stopTimer = false
//    @ObservedObject var audioRecorder : AudioRecorder
//    @State var ishadrecord = false
//    @State var isalert = false
//    var body: some View {
//        ScrollView{
//                VStack{
//                    HStack {
//                        Text("文本标注-单语")
//                            .font(.largeTitle)
//                            .padding(.vertical)
//                    }
//                    VStack{
//                        Text("\(taskmanager.tasksample?.data["text_content"].description ?? "正在加载")")
//                            .fixedSize(horizontal: false, vertical: true)
//                            .frame(width: screen.width-30)
//                            .padding(.top)
//                            .background(Color(red: 0.949, green: 0.949, blue: 0.949))
//                        Spacer().frame(height:0)
//                        //录音控件
//                        VStack{
//                            if isRecord{
//                                Text("\(timeLabel)")
//                                    .foregroundColor(.black)
//                            }
//                            else{
//                                Text("请点击按钮开始录音")
//                                    .foregroundColor(.black)
//                            }
//                            Button(action: {
//                                if !self.isRecord{
//                                    //开始录音
//                                    stopTimer = false
//                                    self.url = self.startStreamRecord(who: "danyuurl")
//                                    print(url)
//                                }
//                                else{
//                                    //停止录音
//                                    self.finishStreamRecord()
//                                    //时间戳清零
//                                    timeLabel = String(format: "%02d:%02d:%02d", 0, 0, 0)
//                                    duration = 0
//                                    stopTimer = true
//                                    ishadrecord = true
//                                    isalert = false
//                                }
//                                self.isRecord.toggle()
//                            }) {
//                                VStack{
//                                    Image(systemName: self.isRecord ? "stop.circle" : "circle")
//                                        .resizable()
//                                        .imageScale(.large)
//                                        .frame(width: screen.width/6, height: screen.width/6)
//                                        .background(isRecord ? Color.black : Color.red)
//                                        .cornerRadius(40)
//                                }
//
//                                //.padding([.top, .leading, .trailing])
//                            }
//                            HStack{
//                                Spacer()
//                                if ishadrecord{
//                                    Button {
//                                        //播放录音音频
//                                        self.audioPlayer.startPlayback(audio: self.url!, atTime: self.currentTime + Double(self.presentDuration)/100)
//                                    } label: {
//                                        Image(systemName: "arrowtriangle.right.circle")
//                                            .resizable()
//                                            .foregroundColor(.blue)
//                                            .frame(width: screen.width/7, height: screen.width/7)
//                                    }
//                                }
//                            }
//
//                        }
//                        .frame(width: screen.width-30, height: screen.width/2, alignment: .center)
//                        .background(Color.white)
//                        .foregroundColor(.white)
//                        Spacer()
//                            .frame(height: 5)
//                            .background(Color(red: 0.949, green: 0.949, blue: 0.949))
//                    }
//                    .frame(width: screen.width-20)
//
//                    //.frame(width: screen.width-20, height: screen.width+10, alignment: .center)
//                    .background(Color(red: 0.949, green: 0.949, blue: 0.949))
//                    .padding(.horizontal)
//
//                }
//
//                Spacer()
//                    .frame(height: screen.width/10)
//                HStack{
//                    Button {
//                        taskmanager.taskskip(task_id: taskmanager.tasksample?.data["task_id"].description ?? "", sample_id: taskmanager.tasksample?.data["text_id"].description ?? "")
//                        //播放录音音频
//                        //self.audioPlayer.startPlayback(audio: self.url!, atTime: self.currentTime + Double(self.presentDuration)/100)
//                    } label: {
//                        Text("跳过")
//                            .frame(maxWidth: screen.width/5)
//                            .foregroundColor(.black)
//                            .padding(.all)
//                    }
//                    .background(Color(red: 0.949, green: 0.949, blue: 0.949))
//                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
//                    .shadow(color: Color.gray, radius: 5, x: 0, y: 3)
//                    Spacer()
//                        .frame(width:screen.width/6)
//                    Button {
//                        if !ishadrecord {
//                            isalert = true
//                        }
//                        //转码base64
//                        if ishadrecord{
//                            let audioData = try? Data(contentsOf: self.url!)
//                            let encodedString = audioData!.base64EncodedString()
//                            //print(encodedString)
//                            let contentstring = """
//{"target_audio": "\(encodedString)"}
//"""
//
//                            let contentjson = JSON.init(rawValue: contentstring)
//                            //print(contentjson)
//                            taskmanager.marktext(task_id: (taskmanager.tasksample?.data["task_id"].description) ?? "", texk_id: taskmanager.tasksample?.data["text_id"].description ?? "", content: contentstring)
//                            ishadrecord = false
//                            url = URL(string: "0")
//                        }
//                    } label: {
//                        Text("下一条")
//                            .frame(maxWidth: screen.width/5)
//                            .foregroundColor(.black)
//                            .padding(.all)
//                    }
//                    .background(Color(red: 0.949, green: 0.949, blue: 0.949))
//                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
//                    .shadow(color: Color.gray, radius: 5, x: 0, y: 3)
//                    .alert(isPresented: $isalert, content: {
//                        Alert(title: Text("标注错误"), message: Text("该数据未录音"), dismissButton: .default(Text("好的")))
//                    })
//                }
//                .padding([.leading, .trailing])
//                .disabled(isRecord)
//                Spacer()
//            }
//        }
//}
