//
//  ContentView.swift
//  My IP
//
//  Created by zhaoxin on 2022/3/5.
//

import SwiftUI
import MyHost

struct ContentView: View {
    @ObservedObject var myHost = MyHost.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 0) {
                Text("My Host State")
                    .font(.title2)
                    .foregroundColor(.green)
                Text(myHost.state)
                    .font(.body)
                    .foregroundColor(.blue)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Network")
                    .font(.title2)
                    .foregroundColor(.green)
                if myHost.reachable {
                    Text("Connected")
                        .font(.body)
                        .foregroundColor(.blue)
                } else {
                    Text("Not Available")
                        .font(.body)
                        .foregroundColor(.red)
                }
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Wired Network")
                    .font(.title2)
                    .foregroundColor(.green)
                Text(show(networkLink:myHost.enthernet))
                    .font(.body)
                    .foregroundColor(.blue)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Wifi Network")
                    .font(.title2)
                    .foregroundColor(.green)
                Text(show(networkLink:myHost.wifi))
                    .font(.body)
                    .foregroundColor(.blue)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Internet")
                    .font(.title2)
                    .foregroundColor(.green)
                Text("IPV4: \(myHost.internetIPV4)")
                    .font(.body)
                    .foregroundColor(.blue)
                Text("IPV6: \(myHost.internetIPV6)")
                    .font(.body)
                    .foregroundColor(.blue)
            }
            
            HStack {
                Button {
                    Task {
                        await myHost.start()
                    }
                } label: {
                    Text("Start")
                }

                Button {
                    myHost.stop()
                } label: {
                    Text("Stop")
                }
            }
        }
        .padding()
        .frame(minWidth: 300, minHeight: 420)
    }
    
    private func show(networkLink:NetworkLink) -> String {
        var result = "Mac: \(networkLink.MAC)"
        
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
        ContentView()
    }
}
