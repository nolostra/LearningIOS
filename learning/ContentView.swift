//
//  ContentView.swift
//  learning
//
//  Created by Saish Dabholkar on 22/12/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userData: UserData
    @State private var lastStoredTimeTextField = ""
    @State private var lastStoredTextField2 = ""
    var body: some View {
        VStack {
            
            Button("Show Stored Details.") {
                let currentData = UserDefaults.standard.string(forKey: "dataString")
                lastStoredTimeTextField = "Last Stored Time: \(String(describing: currentData))"
                let LargeDataString = UserDefaults.standard.string(forKey: "largedataString")
                lastStoredTextField2 = "Last Stored Data: \(String(describing: LargeDataString))"
            }
            
            Button("Store In UserDetails") {
                let LargeDataString = generateLargeString(sizeInMB: 0)
                UserDefaults.standard.set("\(LargeDataString)", forKey: "largedataString")
                let currentTime = getCurrentTime()
                UserDefaults.standard.set("\(currentTime)", forKey: "dataString")
            }
            
            Button("Display from Variables") {
                           lastStoredTimeTextField = "Last Stored Time: \(userData.timeString)"
                           lastStoredTextField2 = "Last Stored Data: \(userData.largeDataString)"
                       }
        }
        .padding()
        
        Text(lastStoredTimeTextField).padding(10)
        Text(lastStoredTextField2)
    }
    func generateLargeString(sizeInMB: Int) -> String {
        let megabyte = 1024 * 1024
        let targetSize = sizeInMB * megabyte
        let currentTime = getCurrentTime()
        var largeString = "\(currentTime)  "

        while largeString.utf8.count < targetSize {
            largeString += "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
            // Add more text or characters as needed to increase the size
        }

        return largeString
    }
    private func getCurrentTime() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            return formatter.string(from: Date())
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(userData: UserData.sample)
    }
}

extension UserData {
    static var sample: UserData {
        let sampleData = UserData.shared
        // Set any sample data you want for preview here
        sampleData.timeString = "Sample Time"
        sampleData.largeDataString = "Sample Large Data"
        return sampleData
    }
}
