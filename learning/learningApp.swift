//
//  learningApp.swift
//  learning
//
//  Created by Saish Dabholkar on 22/12/23.
//

import SwiftUI
import os.log
class UserData: ObservableObject {
    static let shared = UserData()

    @Published var timeString: String = ""
    @Published var largeDataString: String = ""
}

private let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "IOSLogoutLogs")
class AppDelegate: NSObject, UIApplicationDelegate {
    @ObservedObject var userData: UserData = .shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // Fetch data from UserDefaults during app launch
        if let storedTime = UserDefaults.standard.string(forKey: "timeString") {
            print("Retrieved time from UserDefaults in didFinishLaunchingWithOptions: \(storedTime)")
            os_log("Retrieved time from UserDefaults in didFinishLaunchingWithOptions:  %{public}@", log: log, type: .default,"\(storedTime)")
            userData.timeString = storedTime
        } else {
            print("No time data found in UserDefaults during app launch.")
            os_log("No time data found in UserDefaults during app launch.", log: log, type: .default)
        }

        if let storedLargeData = UserDefaults.standard.string(forKey: "largedataString") {
            print("Retrieved large data from UserDefaults in didFinishLaunchingWithOptions: \(storedLargeData)")
            os_log("Retrieved time from UserDefaults in didFinishLaunchingWithOptions:  %{public}@", log: log, type: .default,"\(storedLargeData)")
            userData.largeDataString = storedLargeData
        } else {
            print("No large data found in UserDefaults during app launch.")
            os_log("No large data found in UserDefaults during app launch.", log: log, type: .default)
        }

        return true
    }
}

@main
struct learningApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserData.shared)
        }
    }
}
