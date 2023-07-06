import Foundation
import Domain

public enum AppMock {}

extension AppMock {
  public static var Search: SearchEntity.Response.Result {
    let data = try! Data(contentsOf: BundleToken.bundle.url(forResource: "search", withExtension: "json")!)
    return try! JSONDecoder().decode(SearchEntity.Response.Result.self, from: data)
  }
}
