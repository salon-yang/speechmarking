//
//  MainView.swift
//  SpeechMarking
//
//  Created by Crabbit on 2022/6/10.
//

import SwiftUI

struct MainView: View {
    @State var isupdateversion = false
    //@State var isup2 = true
    @State var versionmessage = ""
    @State var urlString = ""
    @State var test = 1
    @State var ischoosenet = true
    @ObservedObject var lm = LanguageManager.shared_
    func linktoappstore(){
        test = test + 1
        let url = NSURL(string: urlString)
        let success = UIApplication.shared.openURL(url! as URL)
        print("跳转是否成功:\(success.description)")
        //isupdateversion = true
    }
    func chooseChina(){
        netname = netlist.China
        MainManager._shared?.updateurl()
    }
    func chooseother(){
        netname = netlist.Other
        MainManager._shared?.updateurl()
    }
    var body: some View {
        
        //TestaudioView()
        
        TaskListView(isTaskListView: .constant(true), audioRecorder: AudioRecorder())
            .onAppear {
                print(UserDefaults.standard.string(forKey: "langc"))
                LanguageManager.shared_.updatelanguage(languagecode:UserDefaults.standard.string(forKey: "langc") ?? "en")
            }
        
        if #available(iOS 14.0, *) {
            Text("")
                .onChange(of: test, perform: { newValue in
                    VersionController.checkVersion { (message,url)  in
                        versionmessage = message
                        isupdateversion = true
                        
                        print("准备跳转到APP Store！")
                        urlString = url}
                })
                .onAppear {
                    
                    VersionController.checkVersion { (message,url)  in
                        versionmessage = message
                        isupdateversion = true
                        
                        print("准备跳转到APP Store！")
                        urlString = url
                        
                    }
                }

                .alert(isPresented: $isupdateversion, content: {
                    Alert(title: Text("\(lm.mainviewifupdate)"), message: Text(versionmessage), dismissButton: .default(Text("\(lm.returnok)"), action: linktoappstore))
                })
            //NetListView()
        } else {
            // Fallback on earlier versions
        }

    }

}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
