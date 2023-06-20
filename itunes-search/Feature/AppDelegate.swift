import UIKit
import SwiftUI
import LinkNavigator

final class AppDelegate: NSObject {

  let diContainer: DIContainer = {
    DIContainer()
  }()
  
//  var navigator: LinkNavigator {
//    LinkNavigator(dependency: AppDependency(), builders: AppRouterGroup().routers)
//  }
}

extension AppDelegate: UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool
  {
    true
  }
}


