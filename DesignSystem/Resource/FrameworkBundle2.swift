import Foundation

final class BundleToken2 {
  static let bundle: Bundle = {
    Bundle(for: BundleToken2.self)
  }()
}
