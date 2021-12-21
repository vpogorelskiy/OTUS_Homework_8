//
//  OTUS_Homework_8App.swift
//  OTUS_Homework_8 WatchKit Extension
//
//  Created by Вячеслав Погорельский on 21.12.2021.
//

import SwiftUI

@main
struct OTUS_Homework_8App: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
