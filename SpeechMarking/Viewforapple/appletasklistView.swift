//
//  TaskListView.swift
//  SpeechMarking
//
//  Created by Crabbit on 2022/6/20.
//
import SwiftUI
import SwiftyJSON

var appleaccount = true

struct appletasklistView: View {
    @Binding var isappletasklistView : Bool
    @State var viewState = CGSize.zero
    @State var isdeleteaccount = false
    //@State var islogin =
    @State var isapplemarkingview = false
    @State var selfis_bilingual = 0
    @State var selfdata_type = 0
    //voice
    @ObservedObject var audioRecorder : AudioRecorder
    
    //@ObservedObject var packagemanager: PackageManager// = PackageManager()
    func deleteaccount(){
        appleaccount = false
    }
    
    var body: some View {
        ZStack {
                VStack {
                    HStack{
                        Text("数据标注列表")
                            .font(.largeTitle)
                            .padding(.all)
                        Spacer()
                        Button {
                            isdeleteaccount = true
                        } label: {
                            Text("删除账户")
                                .padding(.trailing)
                        }
                        .alert(isPresented: $isdeleteaccount, content: {
                            Alert(title: Text("删除账户"), message: Text("确定删除当前账户吗？该操作不可逆"), primaryButton: .default(Text("不，我再想想")), secondaryButton: .default(Text("是的"),action: deleteaccount))
                        })
                    }
                    .frame(width: screen.width)
                    .background(Color(red: 0.949, green: 0.949, blue: 0.949))
                            VStack {
                                HStack {
                                    Text("中英S-C")
                                        .padding(.all)
                                        .font(.system(size: 22))
                                    Spacer()
                                }
                                HStack{
                                    VStack(alignment: .leading){
                                        Text("类型:")
                                            .padding(.leading)
                                        Text("文本")
                                            .padding([.leading, .bottom])
                                    }
                                    Spacer()
                                    VStack(alignment: .leading){
                                        Text("语言:")
                                            .padding(.leading)
                                        Text("zh")
                                            .padding([.leading, .bottom])
                                    }
                                    Spacer()
                                    VStack(alignment: .leading){
                                        Text("期限时间:")
                                            .padding(.trailing)
                                        Text("2022-07-31")
                                            .padding([.bottom, .trailing])
                                    }
                                }
                                .font(.system(size: 12))
                            }
                            .background(Color(.white))
                            .cornerRadius(10)
                            .onTapGesture {
                                isapplemarkingview = true
                            }
                            Spacer()
                                .background(Color(red: 0.949, green: 0.949, blue: 0.949))

                }
                .background(Color(red: 0.949, green: 0.949, blue: 0.949))
                //.frame(height : screen.height)
                .animation(.easeInOut)
            if isapplemarkingview{
                applemarkingView(isapplemarkingview: $isapplemarkingview)
                    //.frame(width: screen.width, height: screen.height)
                    .offset(x: 0, y: -20)
            }
        }
    }
}
