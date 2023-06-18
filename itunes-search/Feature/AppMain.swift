import SwiftUI

@main
struct AppMain {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
}

extension AppMain {
}

extension AppMain: App {
  var body: some Scene {
    WindowGroup {
      AppSearchPage()
//            .preferredColorScheme(.dark)
    }
  }
}
