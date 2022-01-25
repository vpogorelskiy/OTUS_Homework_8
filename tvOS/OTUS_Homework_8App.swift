import SwiftUI

@main
struct OTUS_Homework_8App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(MoviesViewModel() as BaseViewModel)
        }
    }
}
