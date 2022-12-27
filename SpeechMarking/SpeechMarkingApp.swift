//
//  SpeechMarkingApp.swift
//  SpeechMarking
//
//  Created by Crabbit on 2022/6/9.
//

import SwiftUI
//坑
@available(iOS 14.0, *)
@main
struct SpeechMarkingApp: App {
    
    var body: some Scene {
        WindowGroup {
            MainView()
            //NetListView()
        }
    }
}

//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//
//    var window: UIWindow?
//
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        // code here
//    }
//}
//extension AppDelegate: UIApplicationDelegate {
//    func applicationDidBecomeActive(_ application: UIApplication) {
//        // code here
//    }
//}
