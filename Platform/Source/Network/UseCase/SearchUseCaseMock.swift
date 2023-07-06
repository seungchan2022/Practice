import Foundation
import Domain

public struct SearchUseCaseMock {
  public init() {}
}

extension SearchUseCaseMock: SearchUseCaseDomain {
  public var search: (SearchEntity.Request.Keyword) async throws -> SearchEntity.Response.Result {
    { _ in
      AppMock.Search
    }
  }
}
