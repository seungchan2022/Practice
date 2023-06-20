import SwiftUI
import LinkNavigator

@main
struct AppMain {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  
//  var navigator: LinkNavigator {
//    appDelegate.navigator
//  }
}

extension AppMain {
}

extension AppMain: App {
  var body: some Scene {
    WindowGroup {
//      navigator
//        .launch(paths: ["home"], items: [:])
//        .onOpenURL { url in
//
//        }
      AppSearchPage2()
//            .preferredColorScheme(.dark)
    }
  }
}
