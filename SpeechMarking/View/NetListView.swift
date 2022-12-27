//
//  NetListView.swift
//  SpeechMarking
//
//  Created by Crabbit on 2022/10/11.
//

import SwiftUI

struct NetListView: View {
    @State var netlistchoice = netlist.China
    @State var ischoosenet = true
    func chooseChina(){
        netname = netlist.China
        MainManager._shared?.updateurl()
    }
    func chooseother(){
        netname = netlist.Other
        MainManager._shared?.updateurl()
    }
    var body: some View {
        ZStack{
//            VStack{
//                Picker(selection: $netlistchoice, label: Text("Net Picker")) {
//                    Text("China").tag(netlist.China)
//                    Text("any other country").tag(netlist.Other)
//                }
//            }
//            .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
//            .cornerRadius(30)
//            .padding(.all,10)
            Text("")
                .alert(isPresented: $ischoosenet, content: {
                    Alert(title: Text("Please choose network way"), message: Text("You should choose the country where are you now"),primaryButton: .default(Text("China"),action: chooseChina), secondaryButton: .default(Text("Any Other Country"),action: chooseother))
                })
        }
    }
}

//struct NetListView_Previews: PreviewProvider {
//    static var previews: some View {
//        NetListView()
//    }
//}
