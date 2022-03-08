//
//  My_IPApp.swift
//  My IP
//
//  Created by zhaoxin on 2022/3/5.
//

import SwiftUI
import AppKit
import MyHost

class AppDelegate: NSObject, NSApplicationDelegate {
    var host:MyHost!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        Task {
            host = await MyHost()
        }
    }
}

@main
struct My_IPApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView(enthernet: NetworkLink(MAC: ""), wifi: NetworkLink(MAC: ""), internetIPV4: "", internetIPV6: "")
        }
    }
}


