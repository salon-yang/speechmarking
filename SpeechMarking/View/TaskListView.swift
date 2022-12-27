//
//  TaskListView.swift
//  SpeechMarking
//
//  Created by Crabbit on 2022/6/20.
//
import SwiftUI
import SwiftyJSON

struct TaskListView: View {
    @State var ischoosenet = true
    func chooseChina(){
        netname = netlist.China
        MainManager._shared?.updateurl()
        isloginView = true
    }
    func chooseother(){
        netname = netlist.Other
        MainManager._shared?.updateurl()
        isloginView = true
    }
    @Binding var isTaskListView : Bool
    @ObservedObject var taskmanager = TaskManager.shared
    //@State var userpackage:JSON = PackageManager.shared.userpackage!
    //: JSON
    //@State var isTaskListView = false
    @State var viewState = CGSize.zero
    //@State var islogin =
    @State var isloginView = true
    @State var ismarkingview = false
    @State var selfis_bilingual = 0
    @State var selfdata_type = 0
    @State var isdeleteaccount = false
    @State var ismenuview = false
    @ObservedObject var lm = LanguageManager.shared_
    //voice
    @ObservedObject var audioRecorder : AudioRecorder
    
    //@ObservedObject var packagemanager: PackageManager// = PackageManager()
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    HStack{
                        Text("\(lm.taskviewdatalist)")
                            .font(.largeTitle)
                            .padding(.all)
                        Spacer()
                        if !Logincontroller.shared.loginstatu{
                            Button {
                                isloginView = true
                            } label: {
                                Text("\(lm.tasklistviewlogin)")
                                    .padding(.trailing)
                            }
                        }
                        else{
                            Button(action: {
                                ismenuview.toggle()
                            })
                            {
                                Image(systemName: "list.dash")
                                    .resizable()
                                    .foregroundColor(Color.black)
                                    .frame(width: screen.width/20, height: screen.width/20)
                            }
                            .padding(.trailing, 20)

                        }
                    }
                    .frame(width: screen.width)
                    .background(Color(red: 0.949, green: 0.949, blue: 0.949))
//                    HStack{
//                        if ismenuview{
//                            Spacer()
//                            MenuView(isMenuview: $ismenuview, hadlogin: .constant(true), isloginView: $isloginView)
//                                .frame(width: screen.width/2, height: screen.width/5*2)
//                            //.animation(.easeInOut)
//                        }
//                    }
                    ScrollView{
                        ForEach(taskmanager.taskdatas, id: \.self) { task in
                            VStack {
                                HStack {
                                    Text("\(task.task_name)")
                                        .padding(.all)
                                        .font(.system(size: 22))
                                    Spacer()
                                    Text("\(task.group_num)")
                                        .padding(.trailing)
                                }
                                //                                Spacer()
                                //                                    .frame(height:0)
                                //                                LinearGradient(gradient: Gradient(colors: [Color(red: 0.949, green: 0.949, blue: 0.949), Color(red: 0.949, green: 0.949, blue: 0.949)]), startPoint: .leading, endPoint: .trailing)
                                //                                    .frame(width: screen.width, height: 1, alignment: .leading)
                                //                                Spacer()
                                //                                    .frame(height:0)
                                //                                HStack{
                                //                                    Image("logo")
                                //                                        .resizable()
                                //                                        .frame(width: 100, height: 100)
                                //                                        .padding(.leading)
                                //                                    Spacer()
                                //
                                //                                }
                                HStack{
                                    VStack(alignment: .leading){
                                        Text("\(lm.tasklistviewtype)")
                                            .padding(.leading)
                                        Text(task.data_type.description=="0" ? "文本" : "语音")
                                            .padding([.leading, .bottom])
                                    }
                                    Spacer()
                                    VStack(alignment: .leading){
                                        Text("\(lm.tasklistviewlanguage)")
                                            .padding(.leading)
                                        Text(task.target_language_code==task.source_language_code ? "\(task.source_language_code)" : "\(task.source_language_code) -> \(task.target_language_code)")
                                            .padding([.leading, .bottom])
                                    }
                                    Spacer()
                                    VStack(alignment: .leading){
                                        Text("\(lm.tasklistviewdeadline)")
                                            .padding(.trailing)
                                        Text("\(task.deadline)")
                                            .padding([.bottom, .trailing])
                                    }
                                }
                                .font(.system(size: 12))
                            }
                            .background(Color(.white))
                            .cornerRadius(10)
                            .onTapGesture {
                                taskmanager.getsamplestatu = false
                                if task.task_status == 0{
                                    taskmanager.getsample(token: LoginManager.userInfo!.token, id: task.task_id)
                                    if task.data_type == 0{
                                        print("gettestsample")
                                        taskmanager.gettestsample(token: LoginManager.userInfo!.token, id: task.task_id)
                                    }
                                    selfis_bilingual = task.is_bilingual
                                    selfdata_type = task.data_type
                                    ismarkingview = true
                                }
                                else{
                                    EWToast.showCenterWithText(text: "\(lm.inverification)")
                                }

                            }
                            Spacer()
                                .frame(height: 20)
                                .background(Color(red: 0.949, green: 0.949, blue: 0.949))
                            
                            //.shadow(radius: 10)
                        }
                    }
                    .frame(minHeight: screen.height)
                    Spacer()
                }
                .background(Color(red: 0.949, green: 0.949, blue: 0.949))
            }
            //.frame(height : screen.height/10*8)
            .animation(.easeInOut)
            if isloginView{
                LoginView(isloginView: $isloginView)
            }
            if ismarkingview && taskmanager.getsamplestatu{
                MarkingView(is_bilingual: $selfis_bilingual, data_type: $selfdata_type, ismarkingview: $ismarkingview, audioRecorder: self.audioRecorder)
                    .frame(width: screen.width, height: screen.height)
                    .offset(x: 0, y: 0)
            }
            if ismenuview{
                VStack{
                    if #available(iOS 14.0, *) {
                        MenuView(isMenuview: $ismenuview, hadlogin: .constant(true), isloginView: $isloginView)
                        //.offset(x:)
                            .offset(x: ismenuview ? 0 : -screen.width, y: ismenuview ? -screen.height/10*3: 0)
                            .edgesIgnoringSafeArea(.all)
                            .animation(.easeInOut)
                    } else {
                        // Fallback on earlier versions
                    }
                //.animation(.easeInOut)
                //Spacer()
                }
            }
//            Text("")
//                .alert(isPresented: $ischoosenet, content: {
//                    Alert(title: Text("Please choose network way"), message: Text("You should choose the country where are you now"),primaryButton: .default(Text("China"),action: chooseChina), secondaryButton: .default(Text("Any Other Country"),action: chooseother))
//                })
            
        }
    }
}
