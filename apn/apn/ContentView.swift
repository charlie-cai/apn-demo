import SwiftUI
import NotificationCenter

struct ContentView: View {
  
    var body: some View {
        VStack {
          
          Group {
            Text("bundle id")
            Text(Bundle.main.bundleIdentifier ?? "")
          }
          
          Group {
            Text("Device Token")
            Text(getDeviceToken()).textSelection(.enabled)
          }

          Spacer()
          Button {
            send(deviceToken: getDeviceToken())
          } label: {
            Text("Send Notification")
          }

        }
        .padding()
        .onAppear {
          UIApplication.shared.registerForRemoteNotifications()
        }
    }
  
  func getDeviceToken() -> String {
    UserDefaults.standard.string(forKey: "DEVICE_TOKEN") ?? ""
  }
  
  func send(deviceToken: String) {
    URLSession.shared.dataTask(with: URLRequest(url: URL(string: "http://localhost:5000/push?deviceToken=\(deviceToken)")!)) { data, response, error in
      
    }.resume()
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
