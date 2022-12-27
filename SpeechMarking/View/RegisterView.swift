//
//  RegisterView.swift
//  YunTrans_SwiftUI
//
//  Created by Crabbit on 2021/11/28.
//

//
//  LoginView.swift
//  YunTrans_SwiftUI
//
//  Created by Crabbit on 2021/6/24.
//

import SwiftUI

struct RegisterView: View {
    @State var viewState = CGSize.zero
    //@State var colors = [Color.yellow, Color.orange, Color.red, Color.purple]
    @State var selectedLoginWay = 0
    @State var account : String = ""
    @State var password = ""
    @State var verifycode = ""
    @State var phone = ""
    @State var isgetverifycodealert = false
    @State var isalert = false
    @State var isregisteralert = false
    @State var issendverify = false
    @Binding var isRegisterView : Bool
    @ObservedObject var registercontroller = Logincontroller.shared
    @ObservedObject var lm = LanguageManager.shared_
    func registersuccess(){
        if registercontroller.registerstatu{
            account = ""
            password = ""
            verifycode = ""
            phone = ""
            hideKeyboard()}
    }
    var body: some View {
        ScrollView {
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        account = ""
                        password = ""
                        verifycode = ""
                        phone = ""
                        hideKeyboard()
                        isRegisterView = false
                    }) {
                        Text("\(lm.registerviewreturnlogin)")
                            .foregroundColor(.black)
                    }
                    .frame(width: screen.width/5, height: screen.width/10)
                    .padding(.all, screen.width/18)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                    //.background(Color(red: 0.949, green: 0.949, blue: 0.949))
                }
                .frame(width: screen.width)
                
                //                .gesture(
                //                    DragGesture()
                //                        .onChanged({ value in
                //                            self.viewState = value.translation
                //                            if(self.viewState.height > 10){
                //                                hideKeyboard()
                //                            }
                //                        })
                //                )
                Text("\(lm.registerviewregistration)")
                    .bold()
                    .font(.largeTitle)
                Spacer()
                    .frame(height: screen.width/7)
                VStack {
                    VStack {
                        VStack {
                            Spacer().frame(height: screen.height/70)
                            Divider()
                                .padding(.leading, 25)
                                .padding(.trailing, 17)
                            HStack{
                                Image("account_bold")
                                    .resizable()
                                    .foregroundColor(Color(hue: 0.658, saturation: 0.099, brightness: 0.992))
                                    .frame(width: 44, height: 44)
                                //.background(Color(.white))
                                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                                    .padding(.leading)
                                TextField("\(lm.registerviewsetaccount)", text :$account)
                                    .frame(height: 44)
                                    .keyboardType(.alphabet)
                                    .font(.subheadline)
                                //.textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal)
                            }
                            Divider()
                                .padding(.leading, 25)
                                .padding(.trailing, 17)
                            HStack{
                                Image("password_small")
                                    .resizable()
                                    .foregroundColor(Color(hue: 0.658, saturation: 0.099, brightness: 0.992))
                                    .frame(width: 44, height: 44)
                                //.background(Color(.white))
                                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                                    .padding(.leading)
                                SecureField("\(lm.registerviewsetpassword)", text :$password)
                                    .keyboardType(.default)
                                    .font(.subheadline)
                                    .padding(.horizontal)
                                    .frame(height: 44)
                                
                            }
                            Divider()
                                .padding(.leading, 25)
                                .padding(.trailing, 17)
                            //                            HStack{
                            //                                Image("iphone-1")
                            //                                    .resizable()
                            //                                    .foregroundColor(Color(hue: 0.658, saturation: 0.099, brightness: 0.992))
                            //                                    .frame(width: 44, height: 44)
                            //                                    //.background(Color(.white))
                            //                                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            //                                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            //                                    .padding(.leading)
                            //                                TextField("请输入手机号", text :$phone)
                            //                                    .frame(height: 44)
                            //                                    .keyboardType(.numberPad)
                            //                                    .font(.subheadline)
                            //                                    //.textFieldStyle(RoundedBorderTextFieldStyle())
                            //                                    .padding(.horizontal)
                            //                            }
                            //                            Divider()
                            //                                .padding(.leading, 25)
                            //                                .padding(.trailing, 17)
                        }
                        
                    }
                    Spacer()
                        .frame(height:20)
                    Button(action: {
                        //let LoginManager = LoginManager()
                        //LoginManager.register(username: account, password: password, phone: phone, verifycode: verifycode)
//                        if account == "apple"{
//                            appleaccount = true
//                        }
                        if account=="" || password==""{
                            EWToast.showCenterWithText(text: "\(lm.registerviewnotempty)")
                            isalert = true
                        }
                        else{
                            registercontroller.register(username: account, password: password)
                            isregisteralert = true
                            
                            //isRegisterView = false
                        }
                    }) {
                        Text("\(lm.registerviewregister)")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding(.all)
                    }
                    
                    .background(Color.blue)
                    //.background(Color(hue: 0.553, saturation: 0.392, brightness: 0.971))
                    //.background(Color(hue: 0.553, saturation: 1.0, brightness: 1.0))
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .shadow(color: Color.gray, radius: 5, x: 0, y: 4)
                    .padding(.horizontal, 30)
//                    .alert(isPresented: $isalert) {
//                        Alert(title: Text("账号或密码不得为空"), message: Text("请输入账号和密码"), dismissButton: .default(Text("好的")))
//                    }
                    .alert(isPresented: $isregisteralert) {
                        Alert(title: Text(""), message: Text(registercontroller.registermessage), dismissButton: .default(Text("\(lm.returnok)"), action: {
                            isRegisterView = false
                        }))
                    }
                }
                Spacer()
                    .frame(height:30)
            }
            
        }
        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
        //        .cornerRadius(20)
        //        .animation(.easeInOut)
        .onTapGesture {
            hideKeyboard()
        }
    }
}



//struct RegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterView()
//    }
//}
