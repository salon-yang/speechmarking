//
//  MenuView.swift
//  SpeechMarking
//
//  Created by Crabbit on 2022/9/3.
//

import SwiftUI
enum netlist: String, CaseIterable, Identifiable {
    case China
    case Other
    
    var id: String { self.rawValue }
}

enum Languagelist: String, CaseIterable, Identifiable {
    case zh
    case en
    case vi
    case lo
    case km
    case my
    case th
    
    var id: String { self.rawValue }
}

@available(iOS 14.0, *)
struct MenuView: View {
    
    //@State var netlistchoice = netname
    @AppStorage("netlistchoice") var netlistchoice = netlist.China
    @AppStorage("languagecode") var languagecode = ""
    @AppStorage("languagelistchoice") var languagelistchoice = Languagelist.en
    @Binding var isMenuview : Bool
    @Binding var hadlogin : Bool
    @Binding var isloginView : Bool
    @State var isdeleteaccount = false
    @State var isupdatealert = false
    var menulist = ["语言设置", "检查更新", "删除账号"]
    @State var isupdateversion = false
    @State var versionmessage = ""
    @State var urlString = ""
    @State var isnetlistview = false
    @ObservedObject var lm = LanguageManager.shared_
    
    
    func linktoappstore(){
        let url = NSURL(string: urlString)
        let success = UIApplication.shared.openURL(url! as URL)
        print("跳转是否成功:\(success.description)")
    }
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Spacer()
                    
                    Button(action: {
                        netname = netlistchoice
                        //lanuagename = lanuagelistchoice
                        //MainManager._shared?.updateurl()
                        isMenuview = false
                        //lm.updatelanguage(languagecode: lanuagelistchoice.rawValue)
                    })
                    {
                        Image(systemName: "list.dash")
                            .resizable()
                            .foregroundColor(Color.black)
                            .frame(width: screen.width/20, height: screen.width/20)
                        //.frame(width: 20, height: 20)
                    }
                    .padding(.trailing)
                    
                }
                .padding(.bottom,20)
                .padding(.trailing,5)
                
                //List{
                //VStack{
                Divider()
                HStack{
                    Text("\(lm.menuviewnetwork)")
                    Picker(selection: $netlistchoice, label: Text("")) {
                        Text("\(lm.netchina)").tag(netlist.China)
                        Text("\(lm.netother)").tag(netlist.Other)
                    }
                }
                .padding(.vertical,7)
                //}
                Divider()
//                Button("语言设置") {
//                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
//                }
                HStack {
                    Text("\(lm.menuviewset)")
                    if #available(iOS 14.0, *) {
                        Picker(selection: $languagelistchoice, label: Text("")) {
                            ForEach(Languagelist.allCases, id: \.id){
                                Text($0.rawValue).tag($0)
                            }
                        }
                        .onChange(of: languagelistchoice) { newValue in
                            lm.updatelanguage(languagecode: languagelistchoice.rawValue)
                            UserDefaults.standard.set(languagelistchoice.rawValue, forKey: "langc")
                            //lc = languagelistchoice.rawValue
                            
                        }

                    } else {
                        // Fallback on earlier versions
                    }
                }
                .padding(.vertical,7)
                .frame(maxWidth: .infinity,alignment: .center)
                //存在出现重大bug的可能性
                //.contentShape(Rectangle())
                Divider()
                HStack{
                    Text("\(lm.menuviewupdate)")
                        .frame(maxWidth: .infinity,alignment: .center)
                        .onTapGesture {
                            EWToast.showCenterWithText(text: "\(lm.menuviewnewest)")
                            //                            VersionController.checkVersion { (message,url)  in
                            //                                versionmessage = message
                            //                                isupdateversion = true
                            //                                print("准备跳转到APP Store！")
                            //                                urlString = url
                            //                            }
                        }
                    //                        .alert(isPresented: $isupdateversion, content: {
                    //                            Alert(title: Text("是否进行版本更新？"), message: Text(versionmessage), dismissButton: .default(Text("好的"), action: linktoappstore))
                    //                        })
                }
                .padding(.vertical,7)
                Divider()
                HStack{
                    if hadlogin{
                        Text("\(lm.menuviewdelete)")
                            .frame(maxWidth: .infinity,alignment: .center)
                            .onTapGesture {
                                isdeleteaccount = true
                            }
                            .alert(isPresented: $isdeleteaccount, content: {
                                Alert(title: Text("\(lm.menuviewdelete)"), message: Text("\(lm.menuviewifdelete)"), primaryButton: .default(Text("\(lm.menuviewnotdelete)")), secondaryButton: .default(Text("\(lm.returnok)"),action: {
                                    MainService.promise(.deleteuser).done { (json) in
                                        print("\(json.description)")
                                        TaskManager.shared.taskdatas = []
                                        isloginView = true
                                    }
                                    LoginManager.userInfo = nil
                                }))
                            })
                    }
                    else{
                        Text("\(lm.menuviewnotlogin)")
                            .frame(maxWidth: .infinity,alignment: .center)
                            .onTapGesture {
                                hideKeyboard()
                                isloginView = false
                            }
                    }
                }
                .padding(.top,7)
                //}
            }
            //.padding(.top,30)
            .frame(minWidth: 0, maxWidth:.infinity,maxHeight: screen.height/3)
            .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .cornerRadius(30)
            .padding(.leading,screen.width/5*2)
            .shadow(radius: 20)
            .rotation3DEffect(Angle(degrees: isMenuview ? 0 : 50), axis: (x: 10, y: 10, z: 10))
        }
//        .onAppear {
//            EWToast.showCenterWithText(text: "Please choose network way,You should choose the country where are you now",duration: 8.0)
//        }
        //        if isnetlistview{
        //            NetListView(isnetlistview: $isnetlistview)
        //        }
    }
}

//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView(isMenuview: .constant(true), hadlogin: .constant(true), isloginView: .constant(true))
//    }
//}
