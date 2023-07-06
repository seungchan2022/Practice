import UIKit

final class AppDelegate: NSObject {

  let diContainer: DIContainer = {
    DIContainer()
  }()
}

extension AppDelegate: UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool
  {
    true
  }
}


