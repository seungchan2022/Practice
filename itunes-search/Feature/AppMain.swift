import SwiftUI
import LinkNavigator

@main
struct AppMain {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
}

extension AppMain {
}

extension AppMain: App {
  var body: some Scene {
    WindowGroup {
      AppSearchPage2()
//            .preferredColorScheme(.dark)
    }
  }
}
