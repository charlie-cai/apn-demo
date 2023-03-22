import SwiftUI
import Foundation

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
  func application(_ application: UIApplication,
             didFinishLaunchingWithOptions launchOptions:
                   [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    UNUserNotificationCenter.current().delegate = self
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
      print("granted: (\(granted)")
    }
    //HELLO
    UIApplication.shared.registerForRemoteNotifications()
    return true
  }

  func application(_ application: UIApplication,
              didRegisterForRemoteNotificationsWithDeviceToken
                  deviceToken: Data) {
    UserDefaults.standard.set(deviceToken.hexString, forKey: "DEVICE_TOKEN")
  }

  func application(_ application: UIApplication,
              didFailToRegisterForRemoteNotificationsWithError
                  error: Error) {
     // Try again later.
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    
    print(response.notification.request.content)
    completionHandler()
  }
}

@main
struct apnApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
