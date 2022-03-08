//
//  ContentView.swift
//  My IP
//
//  Created by zhaoxin on 2022/3/5.
//

import SwiftUI
import MyHost

struct ContentView: View {
    @State var enthernet:NetworkLink
    @State var wifi:NetworkLink
    @State var internetIPV4:String
    @State var internetIPV6:String
    
    private let enthernetUpdatePublisher = NotificationCenter.default.publisher(for: MyHost.EnthernetUpdate, object: nil)
    private let wifiUpdatePublisher = NotificationCenter.default.publisher(for: MyHost.WifiUpdate, object: nil)
    private let internetIPV4Publisher = NotificationCenter.default.publisher(for: MyHost.InternetIPV4Update, object: nil)
    private let internetIPV6Publisher = NotificationCenter.default.publisher(for: MyHost.InternetIPV6Update, object: nil)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: -15) {
                Text("Wired Network")
                    .font(.title2)
                    .foregroundColor(.green)
                Text(show(networkLink:enthernet))
                    .font(.body)
                    .foregroundColor(.blue)
                    .onReceive(enthernetUpdatePublisher) { notification in
                        if let enthernet = notification.object as? NetworkLink {
                            self.enthernet = enthernet
                        }
                    }
            }
            
            VStack(alignment: .leading, spacing: -15) {
                Text("Wifi Network")
                    .font(.title2)
                    .foregroundColor(.green)
                Text(show(networkLink:wifi))
                    .font(.body)
                    .foregroundColor(.blue)
                    .onReceive(wifiUpdatePublisher) { notification in
                        if let wifi = notification.object as? NetworkLink {
                            self.wifi = wifi
                        }
                    }
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Internet")
                    .font(.title2)
                    .foregroundColor(.green)
                Text("IPV4: \(internetIPV4)")
                    .font(.body)
                    .foregroundColor(.blue)
                    .onReceive(internetIPV4Publisher) { notification in
                        if let internet = notification.object as? String {
                            internetIPV4 = internet
                        }
                    }
                Text("IPV6: \(internetIPV6)")
                    .font(.body)
                    .foregroundColor(.blue)
                    .onReceive(internetIPV4Publisher) { notification in
                        if let internet = notification.object as? String {
                            internetIPV6 = internet
                        }
                    }
            }            
        }.padding()
        
    }
    
    private func show(networkLink:NetworkLink) -> String {
        var result = "\nMac: \(networkLink.MAC)"
        
        if let ipv4 = networkLink.ipv4 {
            result += "\nIPV4: \(ipv4)"
        } else {
            result += NSLocalizedString("\nIPV4: Inactive", comment: "")
        }
        
        if let ipv6 = networkLink.ipv6 {
            result += "\nIPV6: \(ipv6)"
        } else {
            result += NSLocalizedString("\nIPV6: Inactive", comment: "")
        }
        
        return result
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(enthernet: NetworkLink(MAC: ""), wifi: NetworkLink(MAC: ""), internetIPV4: "", internetIPV6: "")
    }
}
