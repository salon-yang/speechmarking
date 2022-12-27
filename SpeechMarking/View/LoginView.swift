//
//  LoginView.swift
//  YunTrans_SwiftUI
//
//  Created by Crabbit on 2021/6/24.
//

import SwiftUI

struct LoginView: View {
    //@Binding var islogin :Bool
    @State var viewState = CGSize.zero
    @Binding var isloginView : Bool
    //@Binding var ismenuView : Bool
    @State var loginway = ["手机登录", "账号登录"]
    @State var selectedLoginWay = 0
    //真实账户
//            @State var account : String = "20202204171"
//            @State var password = "20202204171"
    @State var account : String = ""
    @State var password = ""
    //测试账户
    //        @State var account : String = "ceshi05"
    //        @State var password = "123456"
    @State var verifycode = ""
    @State var isgetverifycodealert = false
    @State var isloginalert = false
    @State var issendverify = false
    @State var isRegisterView = false
    @State var isTaskView = false
    @State var isclicklogin = false
    @State var isappletasklistview = false
    @State var ismenuview = false
    @ObservedObject var logincontroller = Logincontroller.shared
    @ObservedObject var lm = LanguageManager.shared_
    @State var loginstatu = Logincontroller.shared.loginstatu
    //@State var logincontroller = Logincontroller.shared
    func loginaction(){
        //        if LoginManager.isLogin(){
        //            hideKeyboard()
        //            isloginView = false
        //            isclicklogin = false
        //        }
        //        else{
        //            isclicklogin = false
        //        }
        if LoginManager.isLogin(){
            hideKeyboard()
            isloginView = false
            isclicklogin = false
        }
        else{
            isclicklogin = false
        }
    }
//    func appleloginaction(){
//        hideKeyboard()
//        isappletasklistview = true
//
//        isclicklogin = false
//    }
    var body: some View {
        ZStack{
            ScrollView {
                VStack{
                    HStack{
                        Spacer()
                        Button(action: {
                            ismenuview.toggle()
                        })
                        {
                            Image(systemName: "list.dash")
                                .resizable()
                                .foregroundColor(Color.black)
                                .frame(width: screen.width/20, height: screen.width/20)
                        }
                        //                        Button(action: {
                        //                            hideKeyboard()
                        //                            isloginView = false
                        //                        }) {
                        //                            Text("暂不登录")
                        //                                .foregroundColor(.black)
                        //                        }
                        .padding(.trailing, 20)
                    }
                    .frame(width: screen.width, height: screen.height/20)
                    .background(Color(red: 0.949, green: 0.949, blue: 0.949))

                    Spacer()
                        .frame(height: screen.height/5)
                    Text("\(lm.loginviewtitle)")
//                    Text("用户登录")
                        .bold()
                        .font(.largeTitle)
                    
                    VStack {
                        //账号登录
                        VStack{
                            VStack {
                                HStack{
                                    Image("account_bold")
                                        .resizable()
                                        .foregroundColor(Color(hue: 0.658, saturation: 0.099, brightness: 0.992))
                                        .frame(width: 44, height: 44)
                                        .background(Color(.white))
                                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                        .shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 3)
                                        .padding(.leading)
                                    TextField("\(lm.inputaccount)", text :$account)
                                        .frame(height: 44)
                                        .keyboardType(.alphabet)
                                        .font(.subheadline)
                                    //.textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(.horizontal)
                                }
                                Divider()
                                HStack{
                                    Image("password_small")
                                        .resizable()
                                        .foregroundColor(Color(hue: 0.658, saturation: 0.099, brightness: 0.992))
                                        .frame(width: 44, height: 44)
                                        .background(Color(.white))
                                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                        .shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 3)
                                        .padding(.leading)
                                    HStack{
                                        SecureField("\(lm.inputpassword)", text :$password)
                                            .keyboardType(.default)
                                            .font(.subheadline)
                                            .padding(.horizontal)
                                            .frame(height: 44)
                                        Button(action: {
                                            isRegisterView = true
                                        }) {
                                            Text("\(lm.loginviewregister)")
                                                .frame(maxWidth: .infinity)
                                                .foregroundColor(.black)
                                                .padding(.all)
                                        }
                                        //.frame(maxWidth: .infinity)
                                        .background(Color.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                        //.shadow(color: Color.gray, radius: 10, x: 0, y: 3)
                                        .padding(.horizontal, 20)
                                    }
                                }
                            }
                            .frame(height: 136)
                            .frame(maxWidth: .infinity)
                            
                            //淡紫：Color(hue: 0.658, saturation: 0.099, brightness: 0.992)
                            .background(Color(hue: 0.658, saturation: 0.018, brightness: 0.927))
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: 5)
                            .padding(.horizontal)
                            Spacer()
                                .frame(height:screen.width/10)
                            Button(action: {
//                                if account == "apple" && appleaccount{
//                                    appleloginaction()
//                                }
                                
                                    //let LoginManager = LoginManager()
                                    isclicklogin = true
                                    logincontroller.login(username: account, password: password)
                                    print(isclicklogin)
                                    //LoginManager.login(username: account, password: password)
                                
                            }) {
                                Text("\(lm.loginviewlogin)")
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                                    .padding(.all)
                            }
                            .alert(isPresented: $isclicklogin, content: {
                                Alert(
                                    title: Text(""),
                                    //
                                    message: Text("\(logincontroller.loginmessage)"),
                                    
                                    dismissButton: .default(
                                        Text("\(lm.returnok)"),
                                        action: loginaction
                                    )
                                )
                            })
                            //.frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .shadow(color: Color.gray, radius: 10, x: 0, y: 3)
                            .padding(.horizontal, 30)
                            
   
                        }
                        //}
                    }
                    .disabled(ismenuview)
                    Spacer()
                }
                
            }
            .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .cornerRadius(20)
            .animation(.easeInOut)
            .onTapGesture {
                hideKeyboard()
            }

            if isRegisterView{
                RegisterView(isRegisterView: $isRegisterView)
                    .offset(y:isRegisterView ? screen.height/25 : screen.height)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut)
            }
            
                if ismenuview{
                    VStack{
                        if #available(iOS 14.0, *) {
                            MenuView(isMenuview: $ismenuview, hadlogin: .constant(false), isloginView: $isloginView)
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
        }
    }
}
let screen = UIScreen.main.bounds
func hideKeyboard() {
    UIApplication.shared.sendAction(
        #selector(UIResponder.resignFirstResponder),
        to: nil,
        from: nil,
        for: nil
    )
}
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(islogin: .constant(true), isloginView: .constant(true), ismenuView: .constant(true))
//    }
//}
